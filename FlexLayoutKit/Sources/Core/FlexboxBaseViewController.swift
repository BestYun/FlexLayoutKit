//
//  FlexboxBaseViewController.swift
//  FlexUIKit
//
//  Created by yun on 2023/9/28.
//

import UIKit

open class FlexboxBaseViewController: UIViewController {
        
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.flex
            .direction(.column)
            .crossAxis(.stretch)
            .mainAxis(.start)

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

    open func updateFlexLayout() {
        view.flex.applyLayout()
    }
    
    deinit {
        print("\(self) deinit")
    }
}
