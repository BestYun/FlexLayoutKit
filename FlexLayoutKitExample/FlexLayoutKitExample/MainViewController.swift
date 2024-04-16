//
//  MainViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/4.
//

import FlexLayoutKit
import UIKit

class MainViewController: FlexboxBaseViewController {
    let viewControllers = [
        FlexLayotUIKitViewController.self,
        HelloFlexUIKitViewController.self,
        TableFixedHeightCellViewController.self,
        TableFixedHeightCellViewController2.self,
        TableDynamicHeightCellViewController.self,
        CollectionFixedHeightViewControllerDemo.self,
        CollectionDynamicHeightViewControllerDemo.self,
        HGridFiexdedWidthViewController.self,
        HGridDynamicWidthViewController.self,
        WaterFallViewController.self,
        WrapViewController.self,
        ImageViewController.self,
        HScrollViewController.self,
        VScrollViewController.self,
        HVZStackViewController.self,
        SizeThatFitViewController.self,
        FlexPercentViewController.self,
        CountViewController.self,
        FlexBoxAnimateViewController.self,
        DisplayViewController.self,
    ]
    
    let titles = [
        "FlexLayotKit",
        "Hello FlexLayotKit",
        "UITableViewCell 固定高度",
        "UITableViewCell 固定高度2",
        "UITableViewCell 动态高度",
        "UICollectionViewCell 固定高度",
        "UICollectionViewCell 动态高度",
        "UICollectionViewCell 水平方向 固定宽度",
        "UICollectionViewCell 水平方向 动态宽度",
        "UICollectionView瀑布流",
        "Wrap",
        "Image",
        "HScrollView",
        "VScrollView",
        "HStackView ZStachView ZStackView",
        "SizeThatFits",
        "FlexPercent 百分比",
        "UState",
        "动画",
        "display",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
    }

    @FlexboxViewBuilder override func bodyView() -> [FlexboxView] {
        UITableView().flex.expanded().apply {
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
private class CellItem: TableFixedCell {
    @UState var title: String?
     
    override func bodyView() -> FlexboxView {
        return HStackView {
            Text($title).textColor(.black)
        }
        .crossAxis(.center)
        .padding(.horizontal, 15)
    }
}
