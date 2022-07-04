
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:newsdx/internet_connectivity/internet_status.dart';

enum NetworkStatus {
  Online,
  offline
}

class NetworkStatusService {
  StreamController<NetworkStatus> networkStatusController =  StreamController<NetworkStatus>();
  NetworkStatusService(){
    Connectivity().onConnectivityChanged.listen((status) {
        networkStatusController.add(_getNetworkStatus(status));
    });
  }
  NetworkStatus _getNetworkStatus(ConnectivityResult status){
    return status== ConnectivityResult.mobile || status== ConnectivityResult.wifi ? NetworkStatus.Online : NetworkStatus.offline;
  }
}