//
//  ZStackViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/9/28.
//

import UIKit
import FlexBoxUIKit

class HVZStackViewController: FlexBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func bodyView() -> UIView {
        return VStackView(mainAxis: .center, crossAxis: .center) {
            
            HStackView {
                ImageView().size(40).cornerRadius(10).backgroundColor(.gray.withAlphaComponent(0.2))
                Space(10)
                Text("Leo").textColor(.orange).fontSize(16,weight: .medium)
            }
            .margin(.bottom,10)
            
            VStackView(crossAxis: .center) {
                ImageView().size(40).cornerRadius(10).backgroundColor(.gray.withAlphaComponent(0.2))
                Space(10)
                Text("Leo").textColor(.orange).fontSize(16,weight: .medium)
            }
            .margin(.bottom,10)

            
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
