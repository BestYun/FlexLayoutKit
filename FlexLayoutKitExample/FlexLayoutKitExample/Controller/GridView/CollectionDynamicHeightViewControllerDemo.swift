//
//  CollectionViewControllerDemo.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/3.
//

import FlexLayoutKit
import UIKit

private let reuseIdentifier = "Cell"

///垂直方向的: 动态宽高
class CollectionDynamicHeightViewControllerDemo: FlexboxBaseViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    
    lazy var  layout = UICollectionViewFlowLayout().then { layout in
//        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        //方法一:
        //estimatdItemSize设置一个非0值开启自动计算高度
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 10*2, height: 100)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize 
    }
    
    
    lazy var collectionView: UICollectionView =     UICollectionView(frame: .zero, collectionViewLayout: layout).then { collectionView in
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...5 {
            
            let randomString = NSUUID().uuidString

            let max = Int.random(in: 10 ... 200)
            var content = "start \(i) \(randomString) === "
            var temp: [String] = []
            for _ in 0 ... max {
                temp.append("内容")
            }
            content = content + "\(temp.joined()) end==="
            data.append(content)
        }
    
        view.flex
            .addItems(subviews: bodyView())
    }
    
    @FlexboxViewBuilder  func bodyView() -> [FlexboxView] {
     
        collectionView
            .flex
            .expanded()
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FCollectionCell
        
        cell.text = data[indexPath.row]
                
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did selected item \(indexPath)")
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
//方法二：可以这儿自动计算高度，cell.contentView.flex.sizeThatFits
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FCollectionCell
//        cell.text = data[indexPath.row]
//
//        let size = cell.contentView.flex.sizeThatFits(with: CGSize(width: UIScreen.main.bounds.width - 10*2, height: CGFloat.nan))
//
//        print("width = \(size.width) height = \(size.height)")
//        return  size//CGSize(width: width, height: height)
//    }
}

private class FCollectionCell: GridCell {
    override var isDynamicHeight: Bool { true }
   @UState  var text: String?
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .darkGray
        
    }

    override func bodyView() -> FlexboxView {
        Text($text)
            .fontSize(18)
            .textColor(.orange)
            .backgroundColor(.gray)
            .numberOfLines(0)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
