import 'dart:async';

import 'flutter_user_channel_platform_interface.dart';

class FlutterUserChannel {
  static listenUserToken(Future<dynamic> Function(String?) updateUserToken) {
    FlutterUserChannelPlatform.instance.listenUserToken(updateUserToken);
  }

  static listenOtherInfo(Future<dynamic> Function(dynamic) transmitOtherInfo) {
    FlutterUserChannelPlatform.instance.listenOtherInfo(transmitOtherInfo);
  }
}
