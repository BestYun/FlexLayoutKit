//
//  MainViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/4.
//

import UIKit
import FlexBoxUIKit

class MainViewController: FlexBaseViewController {
    
    
    let viewControllers = [HelloFlexUIKitViewController.self,
                           TableFixedHeightCellViewController.self,
                           TableFixedHeightCellViewController2.self,
                           TableDynamicHeightCellViewController.self,
                           CollectionFixedHeightViewControllerDemo.self,
                           CollectionDynamicHeightViewControllerDemo.self,
                           WrapViewController.self,
                           ImageViewController.self,
                           HScrollViewController.self,
                           VScrollViewController.self,
                           ZStackViewController.self,
                           SizeThatFitViewController.self,
    ]
    
    let titles = ["Hello FlexBoxUIKit",
                  "UITableViewCell 固定高度",
                  "UITableViewCell 固定高度2",
                  "UITableViewCell 动态高度",
                  "UICollectionViewCell 固定高度",
                  "UICollectionViewCell 动态高度",
                  "Wrap",
                  "Image",
                  "HScrollView",
                  "VScrollView",
                  "ZStackView",
                  "SizeThatFits"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
    }
    
    
    override func bodyView() -> UIView {
        return UITableView().flex.expanded().apply {
            
            $0.delegate = self
            $0.dataSource = self
            $0.register(CellItem.self, forCellReuseIdentifier: "cellID")
            $0.rowHeight = 44
        }
    }
    
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CellItem
        
        cell.title = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcSelf = viewControllers[indexPath.row]
        let vc = vcSelf.init()
        vc.title = titles[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

///
private class CellItem: TableCell {
    
   @UState var title: String?
     
    override func bodyView() -> UIView {
        return HStackView {
            Text($title).textColor(.black)
        }
        .padding(.horizontal, 15)
    }
    
}

