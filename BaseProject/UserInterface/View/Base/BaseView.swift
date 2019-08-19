//
//  BaseView.swift
//  BaseProject
//
//  Created by Anonymous on 2019/7/9.
//  Copyright © 2019 Hangzhou Enter Electronic Technology Co., Ltd. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        loadView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        loadView()
    }

    func loadView() {
        //
    }
    
}
