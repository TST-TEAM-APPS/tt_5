import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:tt_5/business/model/user.dart';
import 'package:tt_5/data/repositories/database_service.dart';

class UserController extends ValueNotifier<UserControllerState> {
  UserController() : super(UserControllerState.initial()) {
    _init();
  }

  final _database = GetIt.instance.get<DatabaseService>();

  void _init() {
    final users = _database.users;
    value = value.copyWith(users: users);
  }

  Future<void> create(User user) async {
    await _database.createUser(user);
    refresh();
  }

  // Future<void> delete(User user) async {
  //   final userIndex = value.users.indexOf(user);
  //   await _database.deleteGoal(goalIndex);
  //   refresh();
  // }

  Future<void> edit(User oldUser, User newUser) async {
    final oldUserIndex = value.users.indexOf(oldUser);
    await _database.editUser(oldUserIndex, newUser);
    refresh();
  }

  void refresh() => _init();
}

class UserControllerState {
  final List<User> users;

  const UserControllerState({
    required this.users,
  });

  factory UserControllerState.initial() => const UserControllerState(
        users: [],
      );

  UserControllerState copyWith({
    List<User>? users,
  }) =>
      UserControllerState(
        users: users ?? this.users,
      );
}
