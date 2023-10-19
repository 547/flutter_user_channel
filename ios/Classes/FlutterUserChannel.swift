import Flutter
import UIKit

public class FlutterUserChannel: NSObject {
  public static func updateUserToken(with token: String?, engine: FlutterEngine, callback: @escaping (Any?) -> ()) {
        // 创建渠道
        let channel = FlutterMethodChannel(name: "com.seven.user.flutter_user_channel", binaryMessenger: engine.binaryMessenger)
        // 通过渠道调用 Flutter 的方法
        let params: Dictionary<String, String> = ["token": token ?? ""]
        channel.invokeMethod("updateWithUserToken", arguments: params) { result in
            callback(result)
        }
  }
  /// 传递其他信息
  public static func transmitOtherInfo(with info: [String : Any], engine: FlutterEngine, callback: @escaping (Any?) -> ()) {
        // 创建渠道
        let channel = FlutterMethodChannel(name: "com.seven.user.flutter_user_channel", binaryMessenger: engine.binaryMessenger)
        // 通过渠道调用 Flutter 的方法
        let params = ["info": info]
        channel.invokeMethod("transmitOtherInfo", arguments: params) { result in
            callback(result)
        }
  }
}
