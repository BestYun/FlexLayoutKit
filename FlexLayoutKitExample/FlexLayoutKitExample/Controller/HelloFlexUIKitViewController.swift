//
//  ViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/9/26.
//

import FlexLayoutKit
import UIKit

class HelloFlexUIKitViewController: FlexboxBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.flex
            .addItems(subviews: bodyView())
            .mainAxis(.center)
            .crossAxis(.center)
    }

    @FlexboxViewBuilder func bodyView() -> [FlexboxView] {
        Text("Hello FlexLayoutKit")
    }
}
