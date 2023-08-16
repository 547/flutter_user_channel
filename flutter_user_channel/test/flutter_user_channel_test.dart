import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_user_channel/flutter_user_channel.dart';
import 'package:flutter_user_channel/flutter_user_channel_platform_interface.dart';
import 'package:flutter_user_channel/flutter_user_channel_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUserChannelPlatform
    with MockPlatformInterfaceMixin
    implements FlutterUserChannelPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterUserChannelPlatform initialPlatform = FlutterUserChannelPlatform.instance;

  test('$MethodChannelFlutterUserChannel is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterUserChannel>());
  });

  test('getPlatformVersion', () async {
    FlutterUserChannel flutterUserChannelPlugin = FlutterUserChannel();
    MockFlutterUserChannelPlatform fakePlatform = MockFlutterUserChannelPlatform();
    FlutterUserChannelPlatform.instance = fakePlatform;

    expect(await flutterUserChannelPlugin.getPlatformVersion(), '42');
  });
}
