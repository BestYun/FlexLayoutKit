//
//  UpdateLayoutAndDataViewController.swift
//  FlexLayoutKitExample
//
//  Created by yun on 2024/4/17.
//

import UIKit
import FlexLayoutKit

class UpdateLayoutAndDataViewController: FlexboxBaseViewController {

    var text1: Text?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "更新数据和布局"
        view.flex.addItem(body())
    }
    
    
    func body()->FlexboxView {
        VScrollView {
            
            Text("更新布局,如margin,padding,size")
                .margin(.top,10)
                .backgroundColor(.orange)
                .bindTo(&text1)
            
            Button("update layout")
                .margin(15)
                .height(40)
                .backgroundColor(.blue)
                .onTap { [unowned self] in
                    self.text1?.margin(.top,50).margin(20).height(50)
                    self.updateFlexLayout()
                }
            
        }
        .expanded()
    }
    
 
}
