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
    methodChannel.setMethodCallHandler((call) async {
      Logger.log(
          "Native 调用 Flutter 成功，channel: ${methodChannel.name} 方法：${call.method} 参数是：${call.arguments}");
      switch (call.method) {
        case "updateWithUserToken":
          final token = call.arguments["token"];
          final result = await updateUserToken.call(token);
          return result;
        default:
          return FlutterError("方法名错误");
      }
    });
  }

  @override
  void listenUserToken(
      Future<dynamic> Function(String? value) updateUserToken) {
    this.updateUserToken = updateUserToken;
  }
}
