//
//  FlexPercentViewController.swift
//  FlexBoxUIKitExample
//
//  Created by yun on 2023/11/1.
//

import UIKit
import FlexLayoutKit

class FlexPercentViewController: FlexboxBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @FlexboxViewBuilder override func bodyView() -> [FlexboxView] {

        VStackView (mainAxis: .center, crossAxis: .center){
            
            Text("FlexPercent").backgroundColor(.orange).width(20%).height(20%)
            Text("FlexPercent2").backgroundColor(.blue).size(20%).margin(.top,10)
            Text("FlexPercent3").backgroundColor(.yellow).size(width: 20%, height: 20%).margin(.top,10)
            Text("FlexPercent4").backgroundColor(.gray).size(width: 20%, height: 20%).margin(.top,10%)
            FlexContainer{
                Text("FlexPercent4").backgroundColor(.brown)
            }
            .backgroundColor(.gray)
            .size(width: 50%, height: 20%)
            .margin(.top,10%)
            .padding(10%)
        }.expanded()
    }
}
