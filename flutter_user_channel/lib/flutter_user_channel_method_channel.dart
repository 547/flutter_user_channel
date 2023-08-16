import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_user_channel_platform_interface.dart';

/// An implementation of [FlutterUserChannelPlatform] that uses method channels.
class MethodChannelFlutterUserChannel extends FlutterUserChannelPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_user_channel');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
