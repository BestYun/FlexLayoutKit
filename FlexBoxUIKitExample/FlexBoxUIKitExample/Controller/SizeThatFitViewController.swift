//
//  SizeThatFitViewController.swift
//  FlexBoxUIKitExample
//
//  Created by yun on 2023/11/1.
//

import UIKit

class SizeThatFitViewController: FlexBaseViewController {

    var data = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...10 {
            var text = "index = \(i) end"
            data.append(text)
        }

    }
    override func bodyView() -> UIView {
        
        return UITableView().flex.expanded().apply {
            
            $0.delegate = self
            $0.dataSource = self
            $0.register(CellItem.self, forCellReuseIdentifier: "cellID")
            $0.rowHeight = UITableView.automaticDimension
        }
    }
}
extension SizeThatFitViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CellItem
        cell.text = data[indexPath.row]
        return cell
    }
    
}


private class CellItem: UITableViewCell {
    
    let label = UILabel().apply { label in
        label.numberOfLines = 0

    }
    
    var text: String? {
        didSet{
            label.yoga.markDirty()
            label.text = text
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.flex.applyLayout(mode: .adjustHeight, preservingOrigin: true)
    }
    
    func initUI(){
        self.contentView.flex.addItems {
            label.flex.margin(.left,10).margin(.vertical,10).view
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let tempSize = contentView.flex.sizeThatFits(with: CGSize(width: size.width, height: CGFloat.nan))
        print(tempSize)
        return tempSize
    }
}
