package com.seven.user.flutter_user_channel

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterUserChannelPlugin */
class FlutterUserChannel: FlutterPlugin, MethodCallHandler {
   companion object fun updateUserToken(token: String, engine: FlutterEngine) {
        val messenger = engine.dartExecutor.binaryMessenger

        // 新建一个 Channel 对象
        val channel = MethodChannel(messenger, "com.seven.user.flutter_user_channel")

        // 调用 Flutter 中的方法
        val params = mapOf(
            "token" to token
        )
        channel.invokeMethod("updateWithUserToken", params)
  }
}
