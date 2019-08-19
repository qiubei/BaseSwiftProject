//
//  Notification.swift
//  FlowtimeUI
//
//  Created by Anonymous on 2019/4/3.
//  Copyright © 2019 Hangzhou Enter Electronic Technology Co., Ltd. All rights reserved.
//

import Foundation

/// ble notification user info key
public enum NotificationKey: String {
    case bleStateKey
    case bleBrainwaveKey
    case bleBatteryKey
    case bleHeartRateKey
    case dfuStateKey
    case websocketStateKey
}

struct NotificationName {

}

extension NotificationName {
    static let kTabbarDidChange = Notification.Name("TabbarDidChangeNotificationKey")
}

/// ble notification name
extension NotificationName {
    static let bleStateChanged = Notification.Name("bleStateChangedKey")
    static let bleBrainwaveData = Notification.Name("bleBrainwaveData")
    static let bleBatteryChanged = Notification.Name("bleBatteryChangedKey")
    static let bleHeartRateData = Notification.Name("bleHeartRateDataKey")
    static let dfuStateChanged = Notification.Name("dfuStateChangedKey")
    static let websocketStateDidChanged = Notification.Name("websocketStateDidChangedKey")
}

extension NotificationName {
    static let kFinishWithCloudServieDB = Notification.Name("kFinishWithCloudServieKey")
    static let kFinishWithoutCloudServiceDB = Notification.Name("kFinishWithoutCloudServiceDBKey")
}


//MARK: notification handler
extension Notification.Name {
    func emit(_ userInfo: [String: Any]? = nil) {
        NotificationCenter.default.post(name: self, object: nil, userInfo: userInfo)
    }

    func observe(sender: Any, selector: Selector) {
        NotificationCenter.default.addObserver(sender,
                                               selector: selector,
                                               name: self,
                                               object: nil)
    }
    
    func remove(sender: Any) {
        NotificationCenter.default.removeObserver(sender, name: self, object: nil)
    }
}
