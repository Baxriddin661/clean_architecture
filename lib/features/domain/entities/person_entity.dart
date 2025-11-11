import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final LocationEntity origin;
  final LocationEntity location;
  final String image;
  final List<String> episode;
  final String created; // String bo‘lib qoladi

  const PersonEntity({
    required this.name,
    required this.id,
    required this.status,
    required this.type,
    required this.image,
    required this.species,
    required this.gender,
    required this.created,
    required this.episode,
    required this.location,
    required this.origin,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    status,
    species,
    type,
    gender,
    origin,
    location,
    image,
    episode,
    created,
  ];
}

class LocationEntity {
  final String name;
  final String url;

  const LocationEntity({required this.name, required this.url});
}
