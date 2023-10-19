import Flutter
import UIKit

public class FlutterUserChannel: NSObject {
    public static let shared = FlutterUserChannel()
    public static let methodChannelName = "com.seven.user.flutter_user_channel"
    private var engine: FlutterEngine?
    private var channel: FlutterMethodChannel?
    private var binaryMessenger: FlutterBinaryMessenger?
    /// 是否已经启动
    public var isSetup: Bool {
        var result = false
        if channel != nil, binaryMessenger != nil {
            result = true
        }
        return result
    }
    private override init() {
        super.init()
    }
    /// 通过已有的 FlutterEngine 启动
    public static func setupWithEngine(engine: FlutterEngine) -> FlutterUserChannel {
        let flutterUserChannel = FlutterUserChannel.shared
        flutterUserChannel.engine = engine
        flutterUserChannel.binaryMessenger = engine.binaryMessenger
        // 创建渠道
        flutterUserChannel.channel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: engine.binaryMessenger)
        return flutterUserChannel
    }
    public static func updateUserToken(with token: String?, engine: FlutterEngine, callback: @escaping (Any?) -> ()) {
        let flutterUserChannel = FlutterUserChannel.shared
        if !flutterUserChannel.isSetup {
            setupWithEngine(engine: engine)
        }
        if let channel = flutterUserChannel.channel {
            // 通过渠道调用 Flutter 的方法
            let params: Dictionary<String, String> = ["token": token ?? ""]
            channel.invokeMethod("updateWithUserToken", arguments: params) { result in
                callback(result)
            }
        }
    }
    /// 传递其他信息
    public static func transmitOtherInfo(with info: [String : Any], engine: FlutterEngine, callback: @escaping (Any?) -> ()) {
        let flutterUserChannel = FlutterUserChannel.shared
        if !flutterUserChannel.isSetup {
            setupWithEngine(engine: engine)
        }
        if let channel = flutterUserChannel.channel {
            // 通过渠道调用 Flutter 的方法
            let params = ["info": info]
            channel.invokeMethod("transmitOtherInfo", arguments: params) { result in
                callback(result)
            }
        }
    }
}
