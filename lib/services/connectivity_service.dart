import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  Future<bool> checkConnectivity() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
