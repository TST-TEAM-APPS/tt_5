import 'package:equatable/equatable.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/data/entity/user_entity.dart';

class User extends Equatable {
  final String id;
  final List<ETriggersType> triggers;
  final Map<int, String> customTriggers;

  const User(
      {required this.id, required this.triggers, required this.customTriggers});

  factory User.fromEntity(UserEntity entity) => User(
      id: entity.id,
      triggers: entity.triggers,
      customTriggers: entity.customTriggers);

  @override
  List<Object?> get props => [
        id,
      ];
}
