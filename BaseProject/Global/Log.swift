//
//  Log.swift
//  Flowtime
//
//  Created by Anonymous on 2019/5/7.
//  Copyright © 2019 Enter. All rights reserved.
//

import Foundation

var __isDebug = true

func DLog(_ items: Any...) {
    if __isDebug {
        print("[FLOWTIME DEBUG]: \(items)")
    }
}
