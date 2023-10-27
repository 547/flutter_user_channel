import Flutter
import UIKit

public class FlutterUserChannel: NSObject {
    public static let share = FlutterUserChannel()
    static let tokenChannelName = "com.seven.user.flutter_user_channel.token"
    static let otherInfoChannelName = "com.seven.user.flutter_user_channel.other_info"
    static let tokenChannelMethod = "updateWithUserToken"
    static let otherInfoChannelMethod = "transmitOtherInfo"
    private var tokenChannel: FlutterMethodChannel?
    private var otherInfoChannel: FlutterMethodChannel?
    
    
    private override init() {
        super.init()
    }
    public static func updateUserToken(with token: String?, engine: FlutterEngine, callback: @escaping (Any?) -> ()) {
        if share.tokenChannel == nil {
            // 创建渠道
            share.tokenChannel = FlutterMethodChannel(name: tokenChannelName, binaryMessenger: engine.binaryMessenger)
        }
        
        // 通过渠道调用 Flutter 的方法
        let params: Dictionary<String, String> = ["token": token ?? ""]
        share.tokenChannel?.invokeMethod(tokenChannelMethod, arguments: params) { result in
            callback(result)
        }
    }
    /// 传递其他信息
    public static func transmitOtherInfo(with info: [String : Any], engine: FlutterEngine, callback: @escaping (Any?) -> ()) {
        if share.otherInfoChannel == nil {
            // 创建渠道
            share.otherInfoChannel = FlutterMethodChannel(name: otherInfoChannelName, binaryMessenger: engine.binaryMessenger)
        }
        // 通过渠道调用 Flutter 的方法
        let params = ["info": info]
        share.otherInfoChannel?.invokeMethod(otherInfoChannelMethod, arguments: params) { result in
            callback(result)
        }
    }
}
