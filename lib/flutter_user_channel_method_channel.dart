import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_user_channel/untils/logger.dart';

import 'flutter_user_channel_platform_interface.dart';

/// An implementation of [FlutterUserChannelPlatform] that uses method channels.
class MethodChannelFlutterUserChannel extends FlutterUserChannelPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel('com.seven.user.flutter_user_channel');

  MethodChannelFlutterUserChannel() {
    Logger.log("=========== 初始化Flutter user channel");
    methodChannel.setMethodCallHandler((call) {
      Logger.log(
          "Native 调用 Flutter 成功，channel: ${methodChannel.name} 方法：${call.method} 参数是：${call.arguments}");
      var completer = Completer<dynamic>();
      switch (call.method) {
        case "updateWithUserToken":
          final token = call.arguments["token"];
          updateUserToken.call(token);
          completer.complete("成功");
          break;
        default:
          break;
      }
      return completer.future;
    });
  }

  @override
  void listenUserToken(Function(String? value) updateUserToken) {
    this.updateUserToken = updateUserToken;
  }
}
