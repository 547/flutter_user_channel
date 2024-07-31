import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
  FlutterEngine,
} from '@ohos/flutter_ohos';

export default class FlutterUserChannel {
  static tokenChannelName = "com.seven.user.flutter_user_channel.token"
  static otherInfoChannelName = "com.seven.user.flutter_user_channel.other_info"
  static tokenChannelMethod = "updateWithUserToken"
  static otherInfoChannelMethod = "transmitOtherInfo"
  static methodChannel: MethodChannel | null = null

  static getUserMethodChannel(engine: FlutterEngine): MethodChannel {
    if (FlutterUserChannel.methodChannel == null) {
      FlutterUserChannel.methodChannel = new MethodChannel(engine.dartExecutor.getBinaryMessenger(),
        FlutterUserChannel.tokenChannelName)
    }
    return FlutterUserChannel.methodChannel as MethodChannel
  }

  static updateUserToken(token: string, engine: FlutterEngine) {
    FlutterUserChannel.getUserMethodChannel(engine).invokeMethod(FlutterUserChannel.tokenChannelMethod,
      {
        "token": token
      })

  }

  static transmitOtherInfo(info: Record<string, Object>, engine: FlutterEngine) {
    FlutterUserChannel.getUserMethodChannel(engine).invokeMethod(FlutterUserChannel.tokenChannelMethod,
      {
        "info": info
      })
  }
}