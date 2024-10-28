import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/business/model/mood.dart';
import 'package:tt_5/business/model/user.dart';
import 'package:tt_5/data/entity/mood_entity.dart';
import 'package:tt_5/data/entity/user_entity.dart';

class DatabaseService {
  late final Box<dynamic> _common;
  late final Box<UserEntity> _users;
  late final Box<MoodEntity> _moods;

  Future<DatabaseService> init() async {
    await Hive.initFlutter();
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);
    Hive.registerAdapter(UserEntityAdapter());
    Hive.registerAdapter(ETriggersTypeAdapter());
    Hive.registerAdapter(EEmotionsAdapter());
    Hive.registerAdapter(MoodEntityAdapter());
    _common = await Hive.openBox('_common');
    // await Hive.deleteBoxFromDisk('_moods');
    //await Hive.deleteBoxFromDisk('_users');
    _users = await Hive.openBox('_users');
    _moods = await Hive.openBox('_moods');

    return this;
  }

  //Users
  Future<void> createUser(User newUser) async =>
      await _users.add(UserEntity.fromOriginal(newUser));
  // // Future<void> deleteGame(int index) async => await _games.deleteAt(index);
  List<User> get users => _users.values.map((e) => User.fromEntity(e)).toList();
  Future<void> editUser(int oldUserIndex, User newUser) async {
    var selected = _users.getAt(oldUserIndex);
    selected?.id = newUser.id;
    selected?.triggers = newUser.triggers;
    selected?.customTriggers = newUser.customTriggers;
    await selected?.save();
  }

//Moods
  Future<void> createMood(Mood newMood) async =>
      await _moods.add(MoodEntity.fromOriginal(newMood));
  Future<void> deleteMood(int index) async => await _moods.deleteAt(index);
  List<Mood> get moods => _moods.values.map((e) => Mood.fromEntity(e)).toList();
  Future<void> editMood(int oldMoodIndex, Mood newMood) async {
    var selected = _moods.getAt(oldMoodIndex);
    selected?.id = newMood.id;
    selected?.triggers = newMood.triggers;
    selected?.emotion = newMood.emotion;
    selected?.date = newMood.date;
    selected?.note = newMood.note;
    selected?.customTriggers = newMood.customTriggers;
    await selected?.save();
  }

  //COMMON
  void put(String key, dynamic value) => _common.put(key, value);

  dynamic get(String key) => _common.get(key);
}
