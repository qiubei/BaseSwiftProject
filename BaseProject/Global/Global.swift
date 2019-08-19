//
//  Global.swift
//  FlowtimeUI
//
//  Created by Anonymous on 2019/4/2.
//  Copyright © 2019 Hangzhou Enter Electronic Technology Co., Ltd. All rights reserved.
//

import UIKit

typealias  EmptyBlock = () -> ()
typealias ActionBlock<T> = (T) -> ()

enum FTEmptyResult {
    case success
    case failure
}

enum FTActionResult<T> {
    case success(_ value: T)
    case failure(_ error: Error)
}

extension UIDevice {
    var isIPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}


extension UIView {
    var isShowingOnKeyWindow: Bool {
        let window = UIApplication.shared.keyWindow
        let viewRect = window?.convert(self.frame, from: self.superview)
        let intersects = viewRect?.intersects(CGRect(x: 0, y: 80, width: (window?.bounds.width)!, height: (window?.bounds.height)!-80.0))
        return !self.isHidden && !self.superview!.isHidden && !self.superview!.superview!.isHidden && !self.superview!.superview!.superview!.isHidden && intersects!
    }
}
