//
//  ScrollViewController.swift
//  FlexBoxUIKitExample
//
//  Created by yun on 2023/10/31.
//

import UIKit

class VScrollViewController: FlexBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func bodyView() -> UIView {

        return VScrollView {

            for i in 0...100 {
                FlexContainerView(mainAxis: .center, crossAxis: .center) {
                    Text("\(i)")
                }
                .height(60)
                .backgroundColor(.orange.withAlphaComponent(0.1))
                .margin(.vertical,5)
            }
        }.expanded()
    }

 
}
