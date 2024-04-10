//
//  TableDynamicHeightCellViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/4.
//

import UIKit
import FlexLayoutKit

///tableview cell 动态高度
class TableDynamicHeightCellViewController: FlexboxBaseViewController {

    
    private var data: [InfoData] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0 ... 100 {
            let item = InfoData()
            item.username = "yun\(index)"
            let randomString = NSUUID().uuidString

            let max = Int.random(in: 10 ... 200)
            var content = "start \(index) \(randomString) === "
            var temp: [String] = []
            for _ in 0 ... max {
                temp.append("内容")
            }
            content = content + "\(temp.joined()) end==="
            item.content = content
            item.time = Date().description
            item.imgCount = Int.random(in: 0 ... 9)
            data.append(item)
        }

        
    }
    
    @FlexboxViewBuilder override func bodyView() -> [FlexboxView] {
        UITableView().flex.expanded().apply {
            
            $0.delegate = self
            $0.dataSource = self
            $0.register(CellItem.self, forCellReuseIdentifier: "cellID")
            $0.estimatedRowHeight = 80
            $0.rowHeight = UITableView.automaticDimension
        }
    }
    
}


extension TableDynamicHeightCellViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CellItem
        cell.infoData = data[indexPath.row]
        return cell
    }
    
}

/**
 动态高度,继承TableDynamicCell
 */
//private class CellItem: TableDynamicCell {
private class CellItem: ListCell {
    override var isDynamicHeight: Bool { true }
    @UState private var content: String?
    @UState private var username: String? = ""
    @UState private var time: String? = ""

    var infoData: InfoData? {
        didSet {
            time = infoData?.time
            content = infoData?.content
            username = infoData?.username
        }
    }

    override func bodyView() -> FlexboxView {
        return VStackView {
            
            HStackView {
                UIImageView()
                    .flex
                    .width(36)
                    .height(36)
                    .apply { imageView in
                        imageView.backgroundColor = .systemPink
                    }

                Text($username).expanded().margin(.horizontal, 12)
                
                Text($time)

            }

            Text($content)
                .margin(.top,12)
                .numberOfLines(0)

            Text("工具条")
                .margin(.top,10)
                .height(30)
                .backgroundColor(.cyan)
        }
        .padding(12)
        
    }
    
}


private class InfoData {
    var username: String?
    var userIcon: String?
    var time: String?
    var content: String?

    //    var imgs: [String?]?
    var imgCount: Int?

    var cacheHeight: CGFloat?

    func updateCacheHeight(_ cacheHeight: CGFloat) {
        self.cacheHeight = cacheHeight
    }
}
