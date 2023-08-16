import 'dart:async';

import 'flutter_user_channel_platform_interface.dart';

class FlutterUserChannel {
  static Future<String?> listenUserToken() {
    var completer = Completer<String?>();
    FlutterUserChannelPlatform.instance.listenUserToken((value) {
      completer.complete(value);
    });
    return completer.future;
  }
}
