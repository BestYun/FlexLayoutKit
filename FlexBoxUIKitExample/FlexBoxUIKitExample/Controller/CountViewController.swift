//
//  CountViewController.swift
//  FlexBoxUIKitExample
//
//  Created by yun on 2023/11/2.
//

import UIKit
import FlexBoxUIKit

class CountViewController: FlexBaseViewController {
    @UState var count: String = "count"
    var step: Int = 0 {
        didSet{
            count = "count = \(step)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func bodyView() -> UIView {
        return VStackView(mainAxis: .center, crossAxis: .center,space: 10) {
            Text($count).textColor(.black)
            Button("add").margin(.top,10).backgroundColor(.blue).onTap { [unowned self] in
                self.step = self.step + 1
                //修改内容后,要重新布局
                self.updateFlexLayout()
            }
            Button("test").flex.addItems {
                Text("1").backgroundColor(.blue).size(width: 100, height: 20)
                Text("2").backgroundColor(.systemPink).size(width: 100, height: 20)
            }
            .backgroundColor(.brown)
            .padding(20)
            .apply {
                $0.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            }
            
        }.expanded()
    }
    
    @objc func buttonClick(){
        print("--onclick---")
    }
    
    deinit {
        print("\(self) deinit")
    }
}
