import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Abstract interface for checking internet connectivity.
/// Used by Repository implementations and the ConnectivityInterceptor.
abstract class NetworkInfo {
  /// Returns true if the device has internet access
  Future<bool> get isConnected;

  /// Stream of connectivity changes
  Stream<InternetStatus> get onConnectivityChanged;
}

/// Implementation of NetworkInfo using InternetConnection
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection _internetConnection;

  NetworkInfoImpl({required InternetConnection internetConnection})
    : _internetConnection = internetConnection;

  @override
  Future<bool> get isConnected => _internetConnection.hasInternetAccess;

  @override
  Stream<InternetStatus> get onConnectivityChanged =>
      _internetConnection.onStatusChange;
}
