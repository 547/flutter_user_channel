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
  static tokenChannel: MethodChannel | null = null
  static otherInfoChannel: MethodChannel | null = null

  static getTokenChannel(engine: FlutterEngine): MethodChannel {
    if (FlutterUserChannel.tokenChannel == null) {
      FlutterUserChannel.tokenChannel = new MethodChannel(engine.dartExecutor.getBinaryMessenger(),
        FlutterUserChannel.tokenChannelName)
    }
    return FlutterUserChannel.tokenChannel as MethodChannel
  }
  static getOtherInfoChannel(engine: FlutterEngine): MethodChannel {
    if (FlutterUserChannel.otherInfoChannel == null) {
      FlutterUserChannel.otherInfoChannel = new MethodChannel(engine.dartExecutor.getBinaryMessenger(),
        FlutterUserChannel.otherInfoChannelName)
    }
    return FlutterUserChannel.otherInfoChannel as MethodChannel
  }

  static updateUserToken(token: string, engine: FlutterEngine) {
    FlutterUserChannel.getTokenChannel(engine).invokeMethod(FlutterUserChannel.tokenChannelMethod,
      {
        "token": token
      })

  }

  static transmitOtherInfo(info: Map<string, object>, engine: FlutterEngine) {
    FlutterUserChannel.getOtherInfoChannel(engine).invokeMethod(FlutterUserChannel.otherInfoChannelMethod,
      {
        "info": info
      })
  }
}