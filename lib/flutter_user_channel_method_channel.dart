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
      dynamic result;
      switch (call.method) {
        case "updateWithUserToken":
          final token = call.arguments["token"];
          result = await updateUserToken.call(token);
          break;
        case "transmitOtherInfo":
          final info = call.arguments["info"] as Map<String, dynamic>?;
          Logger.log("===========transmitOtherInfo $info");
          result = await transmitOtherInfo.call(info);
          Logger.log(
              "===========transmitOtherInfo result ${result.toString()}");
          break;
        default:
          result = FlutterError("方法名错误");
          break;
      }
      return result;
    });
  }

  @override
  void listenUserToken(
      Future<dynamic> Function(String? value) updateUserToken) {
    this.updateUserToken = updateUserToken;
  }

  @override
  void listenOtherInfo(
      Future Function(Map<String, dynamic>? value) transmitOtherInfo) {
    Logger.log(
        "=========== set transmitOtherInfo ${transmitOtherInfo.toString()}");
    this.transmitOtherInfo = transmitOtherInfo;
  }
}
