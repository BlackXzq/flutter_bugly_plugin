import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

const String _channelName = 'flutter_bugly_plugin';

class FlutterBuglyPlugin {
  static const MethodChannel _channel = const MethodChannel(_channelName);

  ///
  /// 初始化bugly
  /// [iosAppId] iOS appId
  /// [androidAppId] android appId
  /// [channel] 自定义渠道
  /// [debugModel] SDK Debug信息开关, 默认关闭; "0" 关闭； "1" 开启
  static Future<bool> initBugly({
    required String iosAppId,
    required String androidAppId,
    String? channel,
    String debugModel = "0",
  }) async {
    Map<String, dynamic> args = {
      "appId": Platform.isIOS ? iosAppId : androidAppId,
      "channel": channel ?? '',
      "debugModel": debugModel
    };
    return await _channel.invokeMethod("init", args);
  }

  ///上报自定义异常信息
  /// [error] 错误信息
  /// [stackTrace] 堆栈信息
  static Future<Null> uploadException({
    required String error,
    required String stackTrace,
  }) async {
    var map = {"error": error, "stackTrace": stackTrace};
    await _channel.invokeMethod('uploadException', map);
  }

  ///设置用户标识
  static Future<Null> setUserId(String userId) async {
    Map<String, Object> map = {
      "userId": userId,
    };
    await _channel.invokeMethod("setUserId", map);
  }
}
