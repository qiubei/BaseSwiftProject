//
//  NavigationController.swift
//  BaseProject
//
//  Created by Anonymous on 2019/7/9.
//  Copyright © 2019 Hangzhou Enter Electronic Technology Co., Ltd. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }

    /// 定制统一图片样式的导航栏返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count > 1 {
            viewController.navigationItem.leftBarButtonItem = self.customBackNavigaiontItem()
        }
    }

    /// 更换图片可定制返回图片
    private func customBackNavigaiontItem() -> UIBarButtonItem {
        // may be you can do something!!
        let image = #imageLiteral(resourceName: "icon_navigation_back")
        let item = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.backAction(_:)))
        return item
    }

    @objc
    private func backAction(_ item: UIBarButtonItem) {
        self.popViewController(animated: true)
    }

    /// 默认开启侧滑手势返回方式
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    /// 导航栏是否透明
    var preferredTransparentNavigationBar: Bool = false {
        didSet {
            if preferredTransparentNavigationBar {
                transparentNavigationBar()
            } else {
                defaultNavigationBar()
            }
        }
    }

    private func defaultNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }

    private func transparentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
