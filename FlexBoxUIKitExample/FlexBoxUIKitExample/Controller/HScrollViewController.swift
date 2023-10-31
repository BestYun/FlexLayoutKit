//
//  HScrollViewController.swift
//  FlexBoxUIKitExample
//
//  Created by yun on 2023/10/31.
//

import UIKit

class HScrollViewController: FlexBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func bodyView() -> UIView {
        return HScrollView {
            for i in 0...100 {
                FlexContainerView(mainAxis: .center, crossAxis: .center) {
                    Text("\(i)")
                }
                .width(320)
                .backgroundColor(.orange.withAlphaComponent(0.1))
                .margin(.horizontal,10)
            }

        }
        .margin(.top,200)
        .height(200)
    }
}
