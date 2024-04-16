//
//  TableFixedHeightCellViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/4.
//

import UIKit
import FlexLayoutKit

///tableview cell 固定高度
class TableFixedHeightCellViewController: FlexboxBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.flex.addItems(subviews: bodyView())

    }
    
    @FlexboxViewBuilder  func bodyView() -> [FlexboxView] {
         UITableView().flex.expanded().apply {
            
            $0.delegate = self
            $0.dataSource = self
            $0.register(CellItem.self, forCellReuseIdentifier: "cellID")
            $0.rowHeight = 44
        }
    }
    
}


extension TableFixedHeightCellViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CellItem
        cell.title = "item \(indexPath.row)"
        return cell
    }
    
}


private class CellItem: ListCell {
    
   @UState var title: String?
     
    override func bodyView() -> FlexboxView {
        return HStackView {
            Text($title).textColor(.black)
        }
        .padding(.horizontal, 15)
    }
    
}
