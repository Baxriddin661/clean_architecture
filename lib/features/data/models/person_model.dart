import 'package:clean_architecture/features/data/models/location_model.dart';
import 'package:clean_architecture/features/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
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
      species: json["species"] ?? '',
      gender: json["gender"],
      created: json["created"] ?? '',
      episode: (json["episode"] as List).map((e) => e as String).toList(),
      location: LocationModel.fromJson(json["location"]),
      origin: LocationModel.fromJson(json["origin"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'type': type,
      'gender': gender,
      'origin': (origin as LocationModel).toJson(),
      'location': (location as LocationModel).toJson(),
      'image': image,
      'episode': episode,
      'created': created,
    };
  }
}
