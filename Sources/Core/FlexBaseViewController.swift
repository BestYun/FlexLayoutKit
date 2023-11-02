//
//  FlexBaseViewController.swift
//  FlexUIKit
//
//  Created by yun on 2023/9/28.
//

import UIKit

open class FlexBaseViewController: UIViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.flex.addItems {
            bodyView()
        }
    }

    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFlexLayout()
    }

    override open func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        // 屏幕旋转
        view.flex.size(size).applyLayout()
    }

    open func bodyView() -> UIView {
        fatalError("bodyView has not been implemented")
    }
    
    open func updateFlexLayout() {
        view.flex.applyLayout()
    }
}
