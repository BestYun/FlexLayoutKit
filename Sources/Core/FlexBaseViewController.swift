//
//  FlexBaseViewController.swift
//  FlexUIKit
//
//  Created by yun on 2023/9/28.
//

import UIKit

open class FlexBaseViewController: UIViewController{
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.flex.addItems {
            bodyView()
        }
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.flex.applyLayout()
    }
    
    open func bodyView() -> UIView {
        fatalError("bodyView has not been implemented")
    }
}
