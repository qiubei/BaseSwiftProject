//
//  TapScalable.swift
//  FlowtimeUI
//
//  Created by Anonymous on 2019/4/9.
//  Copyright © 2019 Hangzhou Enter Electronic Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol TapScalable: class {

    func tapped()

    func scale(_ completion: (() -> Void)?)

    func restore(_ completion: (() -> Void)?)

}

extension TapScalable where Self: UIView {

    func tapped() {
        scale {
            self.restore()
        }
    }

    func scale(_ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 4,
                       options: .beginFromCurrentState,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        }) { _ in
            completion?()
        }
    }

    func restore(_ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 4,
                       options: .beginFromCurrentState,
                       animations: {
                        self.transform = CGAffineTransform.identity
        }) { _ in
            completion?()
        }
    }
}
