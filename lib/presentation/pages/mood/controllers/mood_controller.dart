import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:tt_5/business/model/mood.dart';
import 'package:tt_5/data/repositories/database_service.dart';

class MoodController extends ValueNotifier<MoodControllerState> {
  MoodController() : super(MoodControllerState.initial()) {
    _init();
  }

  final _database = GetIt.instance.get<DatabaseService>();

  void _init() {
    final moods = _database.moods;
    value = value.copyWith(moods: moods);
  }

  Future<void> create(Mood mood) async {
    await _database.createMood(mood);
    refresh();
  }

  Future<void> delete(Mood mood) async {
    final moodIndex = value.moods.indexOf(mood);
    await _database.deleteMood(moodIndex);
    refresh();
  }

  Future<void> edit(Mood oldMood, Mood newMood) async {
    final oldMoodIndex = value.moods.indexOf(oldMood);
    await _database.editMood(oldMoodIndex, newMood);
    refresh();
  }

  void refresh() => _init();
}

class MoodControllerState {
  final List<Mood> moods;

  const MoodControllerState({
    required this.moods,
  });

  factory MoodControllerState.initial() => const MoodControllerState(
        moods: [],
      );

  MoodControllerState copyWith({
    List<Mood>? moods,
  }) =>
      MoodControllerState(
        moods: moods ?? this.moods,
      );
}
