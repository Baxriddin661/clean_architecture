import 'package:clean_architecture/features/data/models/location_model.dart';
import 'package:clean_architecture/features/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  PersonModel({
    required super.name,
    required super.id,
    required super.status,
    required super.type,
    required super.image,
    required super.species,
    required super.gender,
    required super.created,
    required super.episode,
    required super.location,
    required super.origin,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      name: json["name"],
      id: json["id"],
      status: json["status"],
      type: json["type"],
      image: json["image"],
      species: json["species"],
      gender: json["gender"],
      created: json["created"],
      episode: (json["episode"] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      location: json["location"] != null
          ? LocationModel.fromJson(json["location"])
          : LocationModel(name: "", url: ""),
      origin: json["origin"] != null
          ? LocationModel.fromJson(json["location"])
          : LocationModel(name: "", url: ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'type': type,
      'gender': gender,
      'origin': origin,
      'location': location,
      'image': image,
      'episode': episode,
      'created': created.toIso8601String(),
    };
  }
}
