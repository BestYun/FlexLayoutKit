//
//  ViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/9/26.
//

import FlexUIKit
import UIKit

class ViewController: FlexBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func bodyView() -> UIView {
        return HStackView(mainAxis: .center, crossAxis: .center) {
            Text("Hello FlexUIKit")
        }
        .flex(1)
    }
}
