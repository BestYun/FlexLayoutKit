//
//  TableFixedHeightCellViewController2.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/4.
//

import UIKit
import FlexUIKit

///tableview cell 固定高度 多个cell的情况下
class TableFixedHeightCellViewController2: FlexBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bodyView() -> UIView {
        return UITableView().flex.expanded().apply {
            
            $0.delegate = self
            $0.dataSource = self
            $0.register(CellItem.self, forCellReuseIdentifier: "cellID")
            $0.register(CellItem2.self, forCellReuseIdentifier: "cellID2")
        }
    }
    
}


extension TableFixedHeightCellViewController2: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row % 2 == 0 ? 44 : 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)

            if let cell = cell as? CellItem {
                cell.title = "item \(indexPath.row)"
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellID2", for: indexPath)

            if let cell = cell as? CellItem2 {
                cell.title = "Leo \(indexPath.row)"
            }
            return cell
            
        }
        
    }
    
}


private class CellItem: TableCell {
    
   @UState var title: String?
     
    override func bodyView() -> UIView {
        return HStackView {
            Text($title).textColor(.black)
        }
        .padding(.horizontal, 15)
    }
    
}

private class CellItem2: TableCell {
    
   @UState var title: String?
     
    override func bodyView() -> UIView {
        return HStackView {
            
            ImageView().size(60).cornerRadius(8).backgroundColor(                UIColor.gray.withAlphaComponent(0.5))
            Space(10)
            VStackView(mainAxis: .spaceAround) {
                HStackView(crossAxis: .center) {
                    Text($title)
                        .fontSize(16, weight: .bold)
                        .expanded()
                        .margin(.right,10)
                    
                    Text("13:30")
                        .fontSize(12, weight: .medium)
                        .textColor(.gray)
                }

                Text("hello,nice to meet you")
            }
            .expanded()
        }
        .height(80)
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
    
}
