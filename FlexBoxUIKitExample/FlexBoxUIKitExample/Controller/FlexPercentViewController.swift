//
//  FlexPercentViewController.swift
//  FlexBoxUIKitExample
//
//  Created by yun on 2023/11/1.
//

import UIKit

class FlexPercentViewController: FlexBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    override func bodyView() -> UIView {
        
        return VStackView (mainAxis: .center, crossAxis: .center){
            
            Text("FlexPercent").backgroundColor(.orange).width(20%).height(20%)
            Text("FlexPercent2").backgroundColor(.blue).size(20%).margin(.top,10)
            Text("FlexPercent3").backgroundColor(.yellow).size(width: 20%, height: 20%).margin(.top,10)
            Text("FlexPercent4").backgroundColor(.gray).size(width: 20%, height: 20%).margin(.top,10%)
            FlexContainerView{
                Text("FlexPercent4").backgroundColor(.brown)
            }
            .backgroundColor(.gray)
            .size(width: 50%, height: 20%)
            .margin(.top,10%)
            .padding(10%)
//            .padding(.left,10%)
//            .padding(.top,10%)

        }.expanded()
    }
}
