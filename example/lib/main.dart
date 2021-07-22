import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bugly_plugin/flutter_bugly_plugin.dart';

void main() {
  ///runZonedGuarded函数给执行对象制定了一个zone，zone 可理解是一个代码执行沙箱，
  ///它能捕获所有未处理的异常（包括同步与异步异常）。
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterBuglyPlugin.initBugly(
          iosAppId: 'c424c5885e', androidAppId: 'c424c5885e');

      ///FlutterError.onError是一个静态函数，
      ///可捕获Widget在build阶段发生的错误异常，我们对其进行重写，把异常信息进行上报处理。
      FlutterError.onError = (FlutterErrorDetails details) {
        //获取 widget build 过程中出现的异常错误
        print(
            "🚗 ${details.exception.toString()} ❌ ${details.stack.toString()}");
        FlutterBuglyPlugin.uploadException(
            error: details.exception.toString(),
            stackTrace: details.stack.toString());
      };
      return runApp(MyApp());
    },
    (error, stackTrace) {
      print("XX: ${error.toString()} |||| ${stackTrace.toString()}");
      FlutterBuglyPlugin.uploadException(
          error: error.toString(), stackTrace: stackTrace.toString());
    },
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        parent.print(zone, line);
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              TextButton(
                onPressed: () {
                  FlutterBuglyPlugin.uploadException(
                      error: "青葱 你错了",
                      stackTrace: "信息你是安全🔐阿水客服即可\n 🙅🤔阿课件卡师傅家");
                },
                child: Text('触发上报异常'),
              ),
              TextButton(
                onPressed: () {
                  var list = [1, 2];
                  var temp = list[3];
                },
                child: Text('触发异常'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
