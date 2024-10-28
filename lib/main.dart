import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:tt_5/business/services/config_service.dart';
import 'package:tt_5/business/services/navigation/navigation_observer.dart';
import 'package:tt_5/business/services/navigation/route_names.dart';
import 'package:tt_5/business/services/navigation/routes.dart';
import 'package:tt_5/business/services/service_locator.dart';
import 'package:tt_5/presentation/themes/app_colors.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await _initApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

Future<void> _initApp() async {
  await ServiceLocator.setup();
  addLifecycleHandler();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EmotionVault Blog: Hub',
      routes: Routes.get(context),
      initialRoute: RouteNames.onboarding,
      navigatorObservers: [
        CustomNavigatorObserver(),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: AppColors.background,
        ),
        useMaterial3: true,
      ),
    );
  }
}

void addLifecycleHandler() {
  WidgetsBinding.instance.addObserver(
    AppLifecycleListener(onDetach: GetIt.instance<ConfigService>().closeClient),
  );
}