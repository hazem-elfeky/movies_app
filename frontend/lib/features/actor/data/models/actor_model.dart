import 'package:my_movies/features/actor/domain/entities/actor_entity.dart';

class ActorModel extends Actor {
  const ActorModel({
    required int id,
    required String name,
    String? image,
    String? character,
    double? popularity,
    String? knownForDepartment,
  }) : super(
         id: id,
         name: name,
         image: image ?? '',
         character: character ?? '',
         popularity: popularity ?? 0.0,
         knownForDepartment: knownForDepartment ?? '',
       );

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    final String image =
        json['profile_path'] as String? ?? json['image'] as String? ?? '';
    final String character = json['character'] as String? ?? '';
    final double popularity = (json['popularity'] != null)
        ? (json['popularity'] as num).toDouble()
        : 0.0;
    final String knownForDepartment =
        json['known_for_department'] as String? ?? '';

    return ActorModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: image,
      character: character,
      popularity: popularity,
      knownForDepartment: knownForDepartment,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'character': character,
      'popularity': popularity,
      'known_for_department': knownForDepartment,
    };
  }
}
