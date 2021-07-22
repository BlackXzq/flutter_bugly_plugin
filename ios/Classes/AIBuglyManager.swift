//
//  AIBuglyManager.swift
//  flutter_bugly_plugin
//
//  Created by xu on 2021/7/22.
//

import Foundation
import Bugly

class AIBuglyManager {
    // 初始化上传 appID channel
    class func initBuglyConfig(appId: String, channel: String, debugMode: Bool = false) {
        // 默认生产id
//        var appId = "c424c5885e"
        let config = BuglyConfig()
        config.reportLogLevel = .error
        config.channel = channel
        
        #if DEBUG
        config.debugMode = debugMode; //SDK Debug信息开关, 默认关闭
        #endif
        
        Bugly.start(withAppId: appId, config: config)
    }
    
    // 可以设置上报用户信息
    class func setUserIdentifier(_ userId: String) {
        Bugly.setUserIdentifier(userId)
    }
    
    // 上报自定义错误
    class func reportException(errorMsg: String, stackTrace: String) {
        Bugly.reportException(withCategory: 5, name: "flutter", reason: errorMsg, callStack: [stackTrace], extraInfo: [:], terminateApp: false)
    }
}
