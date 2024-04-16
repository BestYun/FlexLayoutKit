//
//  HScrollViewController.swift
//  FlexBoxUIKitExample
//
//  Created by yun on 2023/10/31.
//

import UIKit
import FlexLayoutKit

class HScrollViewController: FlexboxBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.flex
            .addItems(subviews: bodyView())

    }
    @FlexboxViewBuilder  func bodyView() -> [FlexboxView] {
        HScrollView (spacing:10){
            for i in 0...100 {
                FlexContainer(mainAxis: .center, crossAxis: .center) {
                    Text("\(i)")
                }
                .width(320)
                .backgroundColor(.orange.withAlphaComponent(0.1))

            }

        }
        .margin(.top,200)
        .height(200)
    }
}
