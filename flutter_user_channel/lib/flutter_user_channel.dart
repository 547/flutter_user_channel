
import 'flutter_user_channel_platform_interface.dart';

class FlutterUserChannel {
  Future<String?> getPlatformVersion() {
    return FlutterUserChannelPlatform.instance.getPlatformVersion();
  }
}
