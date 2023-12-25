// import 'dart:async';
//
// import 'package:common/common_mixin_widgets/common_mixin_widget.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// class NetworkStatusService with ChangeNotifier, CommonWidgets {
//   String connectionStatus = "";
//   bool connectionValue = false;
//   StreamController<bool>? _networkStatusController;
//
//   NetworkStatusService() {
//     _networkStatusController = StreamController<bool>.broadcast();
//     _setupConnectivityListener();
//   }
//
//   Stream<bool> get networkStatusStream => _networkStatusController!.stream;
//
//   void _setupConnectivityListener() {
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       switch (result) {
//         case ConnectivityResult.none:
//           connectionStatus = 'No internet connection';
//           connectionValue = false;
//           _networkStatusController?.add(false);
//           break;
//         case ConnectivityResult.mobile:
//           connectionStatus = 'Connected via mobile data';
//           connectionValue = true;
//           _networkStatusController?.add(true);
//           break;
//         case ConnectivityResult.wifi:
//           connectionStatus = 'Connected via WiFi';
//           connectionValue = true;
//           _networkStatusController?.add(true);
//           break;
//         default:
//           connectionStatus = 'Connected';
//           connectionValue = true;
//           _networkStatusController?.add(true);
//           break;
//       }
//       print('👨‍💻✔ CONNECTIVITY_VALUE_SERVICE_NETWORK:-----> [$connectionValue][$connectionStatus]');
//       commonToast(
//         errorMessage: connectionStatus,
//         backgroundColor:
//             connectionValue == true ? Colors.deepPurpleAccent : Colors.red,
//       );
//       notifyListeners();
//     });
//   }
// }
import 'dart:async';

import 'package:common/common_mixin_widgets/common_mixin_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkStatusService with ChangeNotifier, CommonWidgets {
  String connectionStatus = "No internet connection";
  bool connectionValue = false;

  NetworkStatusService._() {
    _setupConnectivityListener();
  }

  static final NetworkStatusService _instance = NetworkStatusService._();

  factory NetworkStatusService() => _instance;

  void _setupConnectivityListener() {
    final networkStatusController = StreamController<bool>.broadcast();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.none:
          connectionStatus = 'No internet connection';
          connectionValue = false;
          networkStatusController.add(false);
          break;
        case ConnectivityResult.mobile:
          connectionStatus = 'Connected via mobile data';
          connectionValue = true;
          networkStatusController.add(true);
          break;
        case ConnectivityResult.wifi:
          connectionStatus = 'Connected via WiFi';
          connectionValue = true;
          networkStatusController.add(true);
          break;
        default:
          connectionStatus = 'Connected';
          connectionValue = true;
          networkStatusController.add(true);
          break;
      }
      print('👨‍💻✔ CONNECTIVITY_VALUE_SERVICE_NETWORK:-----> [$connectionValue][$connectionStatus]');
      commonToast(
        errorMessage: connectionStatus,
        backgroundColor:
        connectionValue == true ? Colors.deepPurpleAccent : Colors.red,
      );
      notifyListeners();
    });
  }
}

