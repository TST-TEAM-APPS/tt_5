import 'package:hive/hive.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/business/model/mood.dart';
import 'package:tt_5/business/model/user.dart';

part 'mood_entity.g.dart';

@HiveType(typeId: 1)
class MoodEntity extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  List<ETriggersType> triggers;
  @HiveField(2)
  EEmotions emotion;
  @HiveField(3)
  String note;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  Map<int, String> customTriggers;

  MoodEntity(
      {required this.id,
      required this.triggers,
      required this.emotion,
      required this.note,
      required this.date,
      required this.customTriggers});

  factory MoodEntity.fromOriginal(Mood original) => MoodEntity(
      id: original.id,
      triggers: original.triggers,
      emotion: original.emotion,
      note: original.note,
      date: original.date,
      customTriggers: original.customTriggers);
}
