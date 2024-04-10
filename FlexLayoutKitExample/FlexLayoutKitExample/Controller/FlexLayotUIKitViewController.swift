//
//  FlexLayotUIKitViewController.swift
//  FlexLayoutKitExample
//
//  Created by yun on 2024/4/4.
//

import UIKit
import FlexLayoutKit

class FlexLayotUIKitViewController: FlexboxBaseViewController {

    let topView = UIView()
        .flex
        .size(200)
        .margin(.top,100)
        .modifier
        .backgroundColor(.blue)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let orangeView = UIView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        orangeView.backgroundColor = .orange
        
        topView.flexBaseView.addSubview(orangeView)
    }
    
    @FlexboxViewBuilder override func bodyView() -> [FlexboxView] {
        
        topView
        
        Text("testt")
            .fontSize(18)
            .textColor(.red)
            .margin(.left,10)
            .backgroundColor(.orange)
            .margin(.top,10)

    }
    

     

}
