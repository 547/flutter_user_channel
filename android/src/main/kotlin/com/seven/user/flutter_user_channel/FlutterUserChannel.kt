package com.seven.user.flutter_user_channel

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.FlutterEngine

/** FlutterUserChannelPlugin */
class FlutterUserChannel {
    private var tokenChannel: MethodChannel? = null
    private var otherInfoChannel: MethodChannel? = null
   companion object {
       private var instance: FlutterUserChannel? = null
       fun getInstance(): FlutterUserChannel {
           if (instance == null) {
               synchronized(FlutterUserChannel::class) {
                   if (instance == null) {
                       instance = FlutterUserChannel()
                   }
               }
           }
           return instance!!
       }

       private const val tokenChannelName = "com.seven.user.flutter_user_channel.token"
       private const val otherInfoChannelName = "com.seven.user.flutter_user_channel.other_info"
       private const val tokenChannelMethod = "updateWithUserToken"
       private const val otherInfoChannelMethod = "transmitOtherInfo"


       fun updateUserToken(token: String, engine: FlutterEngine) {
           if (instance?.tokenChannel == null) {
               val messenger = engine.dartExecutor.binaryMessenger
               // 新建一个 Channel 对象
               instance?.tokenChannel = MethodChannel(messenger, tokenChannelName)
           }


           // 调用 Flutter 中的方法
           val params = mapOf(
               "token" to token
           )
           instance?.tokenChannel?.invokeMethod(tokenChannelMethod, params)
       }
       fun transmitOtherInfo(info: Map<String, Any>, engine: FlutterEngine) {
           if (instance?.otherInfoChannel == null) {
               val messenger = engine.dartExecutor.binaryMessenger

               // 新建一个 Channel 对象
               instance?.otherInfoChannel = MethodChannel(messenger, otherInfoChannelName)
           }


           // 调用 Flutter 中的方法
           val params = mapOf(
               "info" to info
           )
           instance?.otherInfoChannel?.invokeMethod(otherInfoChannelMethod, params)
       }
   }
}
