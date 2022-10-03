// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImp implements INetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;
  NetworkInfoImp({
    required this.internetConnectionChecker,
  });
  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
