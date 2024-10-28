import 'package:tt_5/business/model/mood.dart';
import 'package:tt_5/business/model/user.dart';
import 'package:tt_5/presentation/pages/mood/controllers/mood_controller.dart';
import 'package:tt_5/presentation/pages/user/controllers/user_controller.dart';

class ChooseTriggersViewArgs {
  bool isEdit;

  ChooseTriggersViewArgs({
    required this.isEdit,
  });
}

class AddMoodViewArgs {
  bool isEdit;
  DateTime? date;
  final Mood? mood;
  final MoodController moodController;
  final UserController userController;

  AddMoodViewArgs(this.mood, this.date,
      {required this.isEdit,
      required this.moodController,
      required this.userController});
}

// class StartSessionViewArgs {
//   final Session session;
//   final SessionController sessionController;
//   final GameController gameController;

//   StartSessionViewArgs(
//       {required this.session,
//       required this.sessionController,
//       required this.gameController});
// }

// class StartedSessionViewArgs {
//   final Session session;
//   final SessionController sessionController;
//   final GameController gameController;

//   StartedSessionViewArgs(
//       {required this.session,
//       required this.sessionController,
//       required this.gameController});
// }

// class AddGameSecondViewArgs {
//   bool isEdit;
//   final Game? game;
//   final GameController gameController;

//   AddGameSecondViewArgs(this.game,
//       {required this.isEdit, required this.gameController});
// }

// class AddMembersViewArgs {
//   bool isEdit;
//   final Session session;
//   final MemberController memberController;
//   final SessionController sessionController;

//   AddMembersViewArgs({
//     required this.isEdit,
//     required this.sessionController,
//     required this.memberController,
//     required this.session,
//   });
// }

// class AddInstructionViewArgs {
//   bool isEdit;
//   final Instruction? instruction;
//   final Game game;
//   final InstructionController instructionController;
//   final GameController gameController;

//   AddInstructionViewArgs(
//     this.instruction, {
//     required this.isEdit,
//     required this.instructionController,
//     required this.gameController,
//     required this.game,
//   });
// }

// class GameViewArgs {
//   final Game game;
//   final GameController gameController;

//   GameViewArgs({required this.game, required this.gameController});
// }

// class InstructionViewArgs {
//   final Game game;
//   final GameController gameController;
//   InstructionViewArgs({required this.game, required this.gameController});
// }
