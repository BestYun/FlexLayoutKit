//
//  ZStackViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/9/28.
//

import UIKit

class ZStackViewController: FlexBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func bodyView() -> UIView {
        return VStackView(mainAxis: .center, crossAxis: .center) {
            
            ZStackView {
                FlexContainerView(mainAxis: .center, crossAxis: .center){
                    Text("99")
                }
                .cornerRadius(15)
                .backgroundColor(.red)
                .top(0)
                .right(0)
                .size(30)
            }
            .size(100)
            .backgroundColor(.orange)
            
        }.expanded()
    }

     
}
