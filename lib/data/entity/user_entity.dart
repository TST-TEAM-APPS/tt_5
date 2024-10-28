import 'package:hive/hive.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/business/model/user.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
class UserEntity extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  List<ETriggersType> triggers;
  @HiveField(2)
  Map<int, String> customTriggers;

  UserEntity(
      {required this.id, required this.triggers, required this.customTriggers});

  factory UserEntity.fromOriginal(User original) => UserEntity(
      id: original.id,
      triggers: original.triggers,
      customTriggers: original.customTriggers);
}
