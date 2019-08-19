//
//  BaseViewController.swift
//  BaseProject
//
//  Created by Anonymous on 2019/7/9.
//  Copyright © 2019 Hangzhou Enter Electronic Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 控制器基类
///
/// 所有的业务视图控制器都应该继承自此基类
class BaseViewController: UIViewController {

    private var _willFirstAppear = false
    private var _didFirstAppear = false


    #if DEBUG
    deinit {
        print("deinit \(type(of: self)).")
    }
    #endif

    /// Shouldn't be overrided by subclass.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        self.loadSubviews()
        self.loadData()
    }

    /// Overrided by subclass.
    func loadSubviews() {
        //
    }

    /// Overrided by subclass.
    func loadData() {
        //
    }

    /// 是否需要隐藏导航栏：重写该方法生效
    var preferredNavigationBarHidden: Bool {
        return false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !_willFirstAppear {
            viewWillFirstAppear()
            _willFirstAppear = true
        }
        // 对于需要隐藏导航栏的，做自动切换
        if preferredNavigationBarHidden {
            navigationController?.delegate = self as UINavigationControllerDelegate
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !_didFirstAppear {
            self.viewDidFirstAppear()
            self._didFirstAppear = true
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !_didFirstAppear {
            viewDidLayoutBeforeFirstAppear()
        }
    }

    /// Overrided by subclass.
    func viewWillFirstAppear() {

    }

    /// Overrided by subclass.
    func viewDidFirstAppear() {

    }

    func viewDidLayoutBeforeFirstAppear() {

    }
    
}

extension UIViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
            navigationController.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController.setNavigationBarHidden(false, animated: true)
            if let delegate = navigationController.delegate as? UIViewController, delegate == self {
                navigationController.delegate = nil
            }
        }
    }
}
