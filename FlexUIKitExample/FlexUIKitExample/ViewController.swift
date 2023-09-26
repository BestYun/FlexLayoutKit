//
//  ViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/9/26.
//

import UIKit
import FlexUIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.flex.addItems {
            HStackView {
                UIView().flex.size(width: 100, height: 100).modifier.backgroundColor(.orange).view
            }
            .margin(.top,100)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.flex.applyLayout()
    }


}

