import Flutter
import UIKit

public class SwiftFlutterBuglyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_bugly_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterBuglyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    // 初始化bugly
    if call.method == "init" {
        // 参数校验
        guard let arguments = call.arguments as? [String: String],
              let appId = arguments["appId"] else {
           return result(false)
        }
        let channel = arguments["channel"] ?? ""
        // debugModel 为"1"时候开启
        let debugModel = arguments["debugModel"] ?? "0"
        AIBuglyManager.initBuglyConfig(appId: appId, channel: channel, debugMode: debugModel == "1")
        
        result(true)
        
    } else if call.method == "setUserId" {
        // 设置userID 信息
        guard let arguments = call.arguments as? [String: String],
              let userId = arguments["userId"] else {
           return result(nil)
        }
        AIBuglyManager.setUserIdentifier(userId)
        result(nil)
    } else if call.method == "uploadException" {
        // 错误上报
        // 参数校验
        guard let arguments = call.arguments as? [String: String],
              let error = arguments["error"] else {
           return result(false)
        }
        let stackTrace = arguments["stackTrace"] ?? ""
        AIBuglyManager.reportException(errorMsg: error, stackTrace: stackTrace)
        result(nil)
    } else {
        result(FlutterMethodNotImplemented);
    }
    
  }
}
