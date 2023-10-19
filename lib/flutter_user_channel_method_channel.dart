import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_user_channel/untils/logger.dart';

import 'flutter_user_channel_platform_interface.dart';

/// An implementation of [FlutterUserChannelPlatform] that uses method channels.
class MethodChannelFlutterUserChannel extends FlutterUserChannelPlatform {
  static const channelNameForToken =
      'com.seven.user.flutter_user_channel.token';
  static const channelNameForOtherInfo =
      'com.seven.user.flutter_user_channel.other_info';

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannelForToken =
      const MethodChannel(MethodChannelFlutterUserChannel.channelNameForToken);
  @visibleForTesting
  final methodChannelForOtherInfo = const MethodChannel(
      MethodChannelFlutterUserChannel.channelNameForOtherInfo);

  MethodChannelFlutterUserChannel() {
    Logger.log("=========== 初始化Flutter user channel");
    methodChannelForToken.setMethodCallHandler(
      (call) async {
        Logger.log(
            "Native 调用 Flutter 成功，channel: ${methodChannelForToken.name} 方法：${call.method} 参数是：${call.arguments}");
        dynamic result;
        final method = call.method;
        switch (method) {
          case "updateWithUserToken":
            final token = call.arguments["token"];
            if (updateUserToken != null) {
              result = await updateUserToken?.call(token);
            } else {
              result = "flutter暂未接收$method方法参数";
            }
            break;
          default:
            result = FlutterError("方法名错误");
            break;
        }
        return result;
      },
    );
    methodChannelForOtherInfo.setMethodCallHandler(
      (call) async {
        Logger.log(
            "Native 调用 Flutter 成功，channel: ${methodChannelForOtherInfo.name} 方法：${call.method} 参数是：${call.arguments}");
        dynamic result;
        final method = call.method;
        switch (method) {
          case "transmitOtherInfo":
            final info = call.arguments["info"];
            if (transmitOtherInfo != null) {
              result = await transmitOtherInfo?.call(info);
            } else {
              result = "flutter暂未接收$method方法参数";
            }
            break;
          default:
            result = FlutterError("方法名错误");
            break;
        }
        return result;
      },
    );
  }

  @override
  void listenUserToken(
      Future<dynamic> Function(String? value) updateUserToken) {
    this.updateUserToken = updateUserToken;
  }

  @override
  void listenOtherInfo(Future Function(dynamic value) transmitOtherInfo) {
    this.transmitOtherInfo = transmitOtherInfo;
  }
}
