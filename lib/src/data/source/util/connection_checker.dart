import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectionChecker {
  static final ConnectionChecker _singleton = ConnectionChecker._internal();

  ConnectionChecker._internal();

  factory ConnectionChecker() {
    return _singleton;
  }

  Future<bool> hasConnection() async {
    if (kIsWeb) return true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.vpn) {
      return true;
    }
    return false;
  }
}
