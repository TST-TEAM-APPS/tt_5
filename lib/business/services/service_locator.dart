import 'package:get_it/get_it.dart';
import 'package:tt_5/business/services/config_service.dart';
import 'package:tt_5/data/repositories/database_service.dart';

class ServiceLocator {
  static Future<void> setup() async {
    GetIt.I.registerSingletonAsync<DatabaseService>(
        () => DatabaseService().init());
    await GetIt.I.isReady<DatabaseService>();
    GetIt.I.registerSingletonAsync<ConfigService>(() => ConfigService().init());
    await GetIt.I.isReady<ConfigService>();
  }
}
