//
//  DisplayViewController.swift
//  FlexLayoutKitExample
//
//  Created by yun on 2024/4/13.
//

import UIKit
import FlexLayoutKit

class DisplayViewController: FlexboxBaseViewController {
    
    lazy var text1 = Text("display:true隐藏view,false显示view,设置值后,需要调用applyLayout进行更新").margin(.top,10).numberOfLines(0)
    var show = true
    
    lazy var container = Column {}.backgroundColor(.orange).margin(20)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "display"
        //修改margin padding size,display之类的只能通过命令式修改text1.margin(10),再调用applyLayout,才会有效果
        

    }
    

    @FlexboxViewBuilder open override func bodyView() -> [FlexboxView] {
        Column {
            text1.alignSelf(.center)
            
            container
            
            Button("切换display")
                .backgroundColor(.orange)
                .margin(.top,10).margin(.horizontal,12)
                .onTap { [unowned self] in
                    self.text1.display(self.show ? false : true)
                    self.show = !self.show
                    container.flex.addItems {
                        Text("append item")
                    }
                    self.updateFlexLayout()
                }
        }
        .margin(.top,100)
        
    }

    deinit{
        print("\(self) deinit")
    }
}
