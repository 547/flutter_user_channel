import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_user_channel/flutter_user_channel_method_channel.dart';

void main() {
  MethodChannelFlutterUserChannel platform = MethodChannelFlutterUserChannel();
  const MethodChannel channel = MethodChannel('flutter_user_channel');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await platform.getPlatformVersion(), '42');
  });
}
