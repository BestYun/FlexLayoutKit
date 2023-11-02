//
//  FlexBoxAnimateViewController.swift
//  FlexBoxUIKitExample
//
//  Created by yun on 2023/11/2.
//

import UIKit

class FlexBoxAnimateViewController: FlexBaseViewController {

    var blowUp = false
    let boxView = FlexContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func bodyView() -> UIView {
        return VStackView(mainAxis: .center, crossAxis: .center) {
            boxView.flex.size(100).modifier.backgroundColor(.blue).view
            
            Button("动画").size(width: 100, height: 30)
                .backgroundColor(.orange).margin(.top,10)
                .onTap { [unowned self] in
                    UIView.animate(withDuration: 0.25, delay: 0) {
                        self.boxView.flex.size(self.blowUp ? 200 : 100)
                        self.updateFlexLayout()
                        self.blowUp = !self.blowUp
                    }
                }
            
        }.expanded()
    }

    
}
