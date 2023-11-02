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
        return VStackView(mainAxis: .center, crossAxis: .center) {
            Text($count).textColor(.black)
            Button("add").margin(.top,10).backgroundColor(.blue).onTap { [unowned self] in
                self.step = self.step + 1
                //修改内容后,要重新布局
                self.updateFlexLayout()
            }
        }.expanded()
    }
    
    deinit {
        print("\(self) deinit")
    }
}
