//
//  ViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/9/26.
//

import FlexUIKit
import UIKit

class HelloFlexUIKitViewController: FlexBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---")
    }

    override func bodyView() -> UIView {
        return Example()
    }
}

class Example: UIView {
    
    lazy var body = HStackView {
        ZStackView {
            ImageView()
                .backgroundColor(UIColor.gray.withAlphaComponent(0.5))
                .cornerRadius(8)
                .left(0)
                .bottom(0)
                .size(width: 50, height: 50)
           
            Text("1")
                .fontSize(12)
                .textColor(.white)
                .right(0)
                .top(0)
                .size(16)
                .cornerRadius(8)
                .backgroundColor(.red)
                .textAlignment(.center)
        }
        .size(58)
        .margin(.right, 8)
       
        VStackView(mainAxis: .spaceAround) {
            HStackView(crossAxis: .center) {
                Text("Leo")
                    .fontSize(16, weight: .bold)
                    .expanded()
                Text("13:30")
                    .fontSize(12, weight: .medium)
                    .textColor(.gray)
            }

            Text("hello,nice to meet you")
        }
        .height(50)
        .expanded()
        .margin(.top, 8)
        
    }
    .padding(.horizontal, 15)
    .margin(.top, 100)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        flex.addItems {
            body
            ExampleGap()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ExampleGap:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let body = Wrap(gap:10){
            for _ in 0...50 {
                UIView().flex.size(20).modifier.backgroundColor(.orange).view
            }
        }.backgroundColor(.blue)
        
        flex.addItem(body)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
