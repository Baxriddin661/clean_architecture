import 'dart:convert';

import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  /// Gets the cashed [List<PersonModel>] which was gotten the last time
  /// the user had an internet connection.
  /// Trows [CacheException] if on cashed data is person.
  Future<List<PersonModel>> getLastPersonsFromCache();

  Future<void> personsToCache(List<PersonModel> persons);
}

const CACHED_PERSONS_LIST = "CACHED_PERSONS_LIST";

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  PersonLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonList = sharedPreferences.getStringList(CACHED_PERSONS_LIST);

    if (jsonPersonList != null) {
      print('Get Persons from Cache: ${jsonPersonList.length}');
      return Future.value(
        jsonPersonList
            .map((person) => PersonModel.fromJson(json.decode(person)))
            .toList(),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList = persons
        .map((person) => json.encode(person.toJson()))
        .toList();
    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    print('Persons to write Cache: ${jsonPersonsList.length}');
    return Future.value(jsonPersonsList);
  }
}
