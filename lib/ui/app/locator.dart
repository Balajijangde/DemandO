import 'package:demando/services/connectivity_service.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

void setuplocator() {
  // locator.registerLazySingleton(() => NavigationService);
  // locator.registerLazySingleton(() => DialogService);
  // locator.registerLazySingleton(() => SnackbarService);
  // locator.registerLazySingleton(() => BottomSheetService);
  // locator.registerLazySingleton(() => Auth);
  // locator.registerLazySingleton(() => Database);
  locator.registerSingleton<SnackbarService>(SnackbarService());
  locator.registerSingleton<ConnectivityService>(ConnectivityService());
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<DialogService>(DialogService());
}
