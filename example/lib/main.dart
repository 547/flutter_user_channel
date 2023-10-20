import 'package:flutter/material.dart';
import 'dart:async';

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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterUserChannelPlugin = FlutterUserChannel();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    // try {
    //   platformVersion =
    //       await _flutterUserChannelPlugin.getPlatformVersion() ?? 'Unknown platform version';
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
