import 'package:flutter/cupertino.dart';
import 'package:tt_5/business/helpers/arguments.dart';
import 'package:tt_5/business/services/navigation/route_names.dart';
import 'package:tt_5/presentation/pages/agreement_view.dart';
import 'package:tt_5/presentation/pages/main_view.dart';
import 'package:tt_5/presentation/pages/mood/pages/add_mood_view.dart';
import 'package:tt_5/presentation/pages/onboarding_view.dart';
import 'package:tt_5/presentation/pages/privacy_view.dart';
import 'package:tt_5/presentation/pages/settings_view.dart';
import 'package:tt_5/presentation/pages/splash_view.dart';
import 'package:tt_5/presentation/pages/user/pages/choose_triggers_view.dart';

typedef ScreenBuilding = Widget Function(BuildContext context);

class Routes {
  static Map<String, ScreenBuilding> get(BuildContext context) {
    return {
      RouteNames.onboarding: (context) => const OnboardingView(),
      RouteNames.splash: (context) => const SplashView(),
      RouteNames.chooseTriggersView: (context) {
        final arguments = ModalRoute.of(context)!.settings.arguments
            as ChooseTriggersViewArgs;
        return ChooseTriggersView(args: arguments);
      },
      RouteNames.addMoodView: (context) {
        final arguments =
            ModalRoute.of(context)!.settings.arguments as AddMoodViewArgs;
        return AddMoodView(args: arguments);
      },
      RouteNames.main: (context) => const MainView(),
      RouteNames.settings: (context) => const SettingsView(),
      RouteNames.privacy: (context) => const PrivacyView(),
      RouteNames.agreement: (context) => AgreementView.create(context),
    };
  }
}
