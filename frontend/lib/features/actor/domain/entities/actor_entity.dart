import 'package:equatable/equatable.dart';

class Actor extends Equatable {
  final int id;
  final String name;
  final String image;
  final String character;
  final double popularity;
  final String knownForDepartment;

  const Actor({
    required this.id,
    required this.name,
    this.image = '',
    this.character = '',
    this.popularity = 0.0,
    this.knownForDepartment = '',
  });

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    character,
    popularity,
    knownForDepartment,
  ];
}
