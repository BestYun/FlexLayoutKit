//
//  ViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/9/26.
//

import FlexBoxUIKit
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
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ExampleGap: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let body = Wrap(gap: 10) {
            for _ in 0 ... 50 {
                UILabel()
                    .flex.size(60)
                    .borderWidth(5)
                    .modifier.backgroundColor(.orange).view
                    .apply {
                        $0.layer.borderWidth = 5
                        $0.layer.borderColor = UIColor.red.cgColor
//                        let border = CALayer()
//                        border.frame = CGRectMake(0, 60 - 10, 60, 10)
//                        border.backgroundColor = UIColor.red.cgColor
//                        $0.layer.addSublayer(border)
                    }
            }
        }
        
        flex.addItem(body)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ZStackExample: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .purple
        flex.enabled(true)
            .position(.relative)
            .direction(.row)
            .addItems {
                Text("left").left(10).top(10).backgroundColor(.orange).position(.relative)
                
                UIView().flex
                    .width(100)
                    .height(20)
                    .top(0)
                    .left(20)
                    .position(.relative)
                    .modifier.backgroundColor(.red).view

                Text("right").left(10).top(0).backgroundColor(.gray).position(.relative)
            }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
