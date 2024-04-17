//
//  ViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/9/26.
//

import FlexLayoutKit
import UIKit

class HelloFlexUIKitViewController: FlexboxBaseViewController {
    
    var text: Text?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.flex
            .mainAxis(.center)
            .crossAxis(.center)
            .addItems(subviews: bodyView())
            
    }

    @FlexboxViewBuilder func bodyView() -> [FlexboxView] {
        
        Text("Hello FlexLayoutKit")
            .bindTo(&text)
        
        Button("insert aboveSubview")
            .backgroundColor(.orange)
            .padding(.horizontal, 10)
            .margin(10)
            .onTap { [unowned self] in

                
                self.view.flex.insertItems(aboveSubview: text!) {
                    Text("subview 1").margin(10)
                    Text("subview 2").margin(10)
                    Text("subview 3").margin(10)
                    Text("subview 4").margin(10)
                    Text("subview 5").margin(10)
                }
                self.updateFlexLayout()
                print(self.view.subviews)
        }
        
        Button("belowSubview text")
            .backgroundColor(.orange)
            .padding(.horizontal, 10)
            .margin(10)
            .onTap { [unowned self] in
                
                self.view.flex.insertItems(belowSubview: text!) {
                    Text("subview 6").margin(10)
                    Text("subview 7").margin(10)
                    Text("subview 8").margin(10)
                    Text("subview 9").margin(10)
                    Text("subview 10").margin(10)
                }
                self.updateFlexLayout()
                print(self.view.subviews)
        }
    }
}
