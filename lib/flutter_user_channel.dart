import 'dart:async';

import 'flutter_user_channel_platform_interface.dart';

class FlutterUserChannel {
  listenUserToken(Future<dynamic> Function(String?) updateUserToken) {
    FlutterUserChannelPlatform.instance.listenUserToken(updateUserToken);
  }
}
