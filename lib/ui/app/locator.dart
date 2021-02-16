import 'package:demando/services/connectivity_service.dart';
import 'package:demando/ui/widgets/product_checkout_bottomsheet.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';
import "package:demando/AppConstants.dart";

final locator = GetIt.instance;

void setuplocator() {
  // locator.registerLazySingleton(() => Auth);
  // locator.registerLazySingleton(() => Database);
  locator.registerSingleton<SnackbarService>(SnackbarService());
  locator.registerSingleton<ConnectivityService>(ConnectivityService());
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<DialogService>(DialogService());
  locator.registerSingleton<BottomSheetService>(BottomSheetService());
}

void setupBottomSheetUi() {
  final BottomSheetService bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.ProductCheckout: (context, sheetRequest, completer) =>
        ProductCheckoutBottomSheet(request: sheetRequest, completer: completer)
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
