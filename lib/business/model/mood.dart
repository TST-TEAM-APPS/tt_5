import 'package:equatable/equatable.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/data/entity/mood_entity.dart';
import 'package:tt_5/data/entity/user_entity.dart';

class Mood extends Equatable {
  final String id;
  final List<ETriggersType> triggers;
  final EEmotions emotion;
  final String note;
  final DateTime date;
  final Map<int, String> customTriggers;

  const Mood(
      {required this.id,
      required this.triggers,
      required this.emotion,
      required this.note,
      required this.date,
      required this.customTriggers});

  factory Mood.fromEntity(MoodEntity entity) => Mood(
      id: entity.id,
      triggers: entity.triggers,
      emotion: entity.emotion,
      note: entity.note,
      date: entity.date,
      customTriggers: entity.customTriggers);

  @override
  List<Object?> get props => [
        id,
      ];
}
