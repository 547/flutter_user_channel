# flutter_user_channel

该插件主要用于flutter和原生混编时(配合了[flutter_boost](https://github.com/alibaba/flutter_boost)一起使用的)，原生（android和iOS）更新flutter中的user token、 其它信息.

## Getting Started

### flutter 中的使用

```dart
import 'package:flutter_user_channel/flutter_user_channel.dart';

void main() {
  /// 监听原生传递过来的token
  FlutterUserChannel.listenUserToken(
    (p0) {
      var completer = Completer();
      print("============ 接收到的user token $p0");
      // 这里写数据的处理
      if (p0 == null) {
        completer.complete("========== 接收到user token 为空，已经退出登录");
      } else {
        completer.complete("========== 接收到user token $p0");
      }
      return completer.future;
    },
  );

  /// 监听原生传递过来的其它信息
  FlutterUserChannel.listenOtherInfo(
    (p0) {
      var completer = Completer();
      print("============ 接收到的数据 $p0");
      // 这里写数据的处理
      completer.complete("========== 已经接收到数据 $p0");
      return completer.future;
    },
  );
  // ...
  runApp(const MyApp());
}
```

### iOS 中的使用

```swift
import flutter_boost
import flutter_user_channel
class AppDelegate: UIResponder, UIApplicationDelegate {
    // 创建代理，做初始化操作
    var flutterBoostDelegate = GMFlutterBoostDelegate()
    var flutterEngine: FlutterEngine?
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // ...
        // 配置Flutter
        configFlutterBoost(application)
        // 向flutter同步token
        let token = "token"
        updateUserTokenInFlutter(token)
        return true
    }
}
extension AppDelegate {
    /// 设置flutter
    func configFlutterBoost(_ application: UIApplication) {
        let boostDelegate = GMFlutterBoostDelegate()
        flutterBoostDelegate = boostDelegate
        FlutterBoost.instance().setup(application, delegate: flutterBoostDelegate) {[weak self] engine in
            self?.flutterEngine = engine
        }
    }
}
extension AppDelegate {
    /// 更新flutter中的token
    func updateUserTokenInFlutter(_ token: String?) -> () {
        guard let flutterEngine = flutterEngine else { return }
        FlutterUserChannel.updateUserToken(with: token, engine: flutterEngine) {[weak self] result in
            print("============updateUserToken \(String(describing: result))")
        }
    }
    /// 传递数据到flutter
    func transmitOtherInfoToFlutter(_ value: [String : Any]) -> () {
        guard let flutterEngine = flutterEngine else { return }
        FlutterUserChannel.transmitOtherInfo(with: value, engine: flutterEngine) { result in
            print("============transmitOtherInfo \(String(describing: result))")
        }
    }
}

```

### Android 中的使用
#### android使用的类和方法是iOS的一样的都是用FlutterUserChannel类然后根据业务场景调用updateUserToken/transmitOtherInfo方法即可。

```kotlin


```