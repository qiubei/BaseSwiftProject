//
//  Device.swift
//  Flowtime
//
//  Created by Anonymous on 2019/7/9.
//  Copyright © 2019 Enter. All rights reserved.
//

import UIKit

class Device {
    static let current = UIDevice()
}

extension UIDevice {
    var isiphoneX: Bool {
        if #available(iOS 11, *) {
            if let w = UIApplication.shared.delegate?.window,
                let window = w, window.safeAreaInsets.left > 0 || window.safeAreaInsets.bottom > 0 {
                return true
            }
        }
        return false
    }
}
