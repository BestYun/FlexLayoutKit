//
//  ViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/9/26.
//

import FlexLayoutKit
import UIKit

class HelloFlexUIKitViewController: FlexboxBaseViewController {
    
    var text: FlexboxView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.flex
            .mainAxis(.center)
            .crossAxis(.center)
            .addItems(subviews: bodyView())
            
    }

    @FlexboxViewBuilder func bodyView() -> [FlexboxView] {
        Text("Hello FlexLayoutKit")
            //.bindToBoxView(&text)
        
        Button("change text")
            .backgroundColor(.orange)
            .padding(.horizontal, 10)
            .margin(10)
            .onTap {
//                text?.flexBaseView.modifier.text("")
            
        }
    }
}
