//
//  ScrollViewController.swift
//  FlexBoxUIKitExample
//
//  Created by yun on 2023/10/31.
//

import UIKit
import FlexLayoutKit

class VScrollViewController: FlexboxBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.flex
            .addItems(subviews: bodyView())
    }
    
    @FlexboxViewBuilder  func bodyView() -> [FlexboxView] {

        VScrollView(spacing:5) {
            for i in 0...100 {
                FlexContainer(mainAxis: .center, crossAxis: .center) {
                    Text("\(i)")
                }
                .height(60)
                .backgroundColor(.orange.withAlphaComponent(0.1))
            }
        }.expanded()
    }

 
}
