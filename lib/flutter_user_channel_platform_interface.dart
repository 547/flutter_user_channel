import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_user_channel_method_channel.dart';

abstract class FlutterUserChannelPlatform extends PlatformInterface {
  /// Constructs a FlutterUserChannelPlatform.
  FlutterUserChannelPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterUserChannelPlatform _instance =
      MethodChannelFlutterUserChannel();

  /// The default instance of [FlutterUserChannelPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterUserChannel].
  static FlutterUserChannelPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterUserChannelPlatform] when
  /// they register themselves.
  static set instance(FlutterUserChannelPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  late Future<dynamic> Function(String? value) updateUserToken;
  late Future<dynamic> Function(Map<String, dynamic>? value) transmitOtherInfo;
  void listenUserToken(
      Future<dynamic> Function(String? value) updateUserToken) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void listenOtherInfo(
      Future<dynamic> Function(Map<String, dynamic>? value) transmitOtherInfo) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
