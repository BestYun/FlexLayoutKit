//
//  ViewController2.swift
//  FlexLayoutKitExample
//
//  Created by yun on 2024/4/1.
//

import UIKit
import FlexLayoutKit

class ViewController2: FlexboxBaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "page2"
         
    }
    
    @FlexboxViewBuilder  func bodyView() -> [FlexboxView] {
            
            UIButton()
                .flex
                .width(100)
                .height(100)
                .margin(.top,10)
                .margin(.left,100)
                .modifier
                .backgroundColor(.blue)
                .apply { button in
                    button.addTarget(self, action: #selector(backClick), for: .touchUpInside)
                }
            
            Spacer(20)
            
            UIButton()
                .flex
                .width(100)
                .height(100)
                
                .margin(.left,100)
                .modifier
                .backgroundColor(.orange)
                .apply { button in
                    button.addTarget(self, action: #selector(backClick), for: .touchUpInside)
                }
        
        Row {
            Text("1").size(20).backgroundColor(.orange)
            Text("2").size(20).backgroundColor(.orange)
            Text("2").size(20).backgroundColor(.orange)
        }
        .spacing(150)
        
        
    }
    
    

    @objc func backClick() {
        navigationController?.popViewController(animated: true)
    }

    deinit {
        print("\(self) deinit")
    }
}
