//
//  WaterFallViewController.swift
//  FlexLayoutKitExample
//
//  Created by yun on 2024/4/5.
//

import FlexLayoutKit
import UIKit

private let reuseIdentifier = "Cell"


// ## UICollectionView
// * https://juejin.cn/post/6944994974614323213?searchId=20240405171041254EDFB1442A61513BDF
// * https://linxunfeng.top/2017/09/12/ios-swift-uicollectionview%E6%A8%AA%E5%90%91%E5%88%86%E9%A1%B5%E6%BB%9A%E5%8A%A8%EF%BC%8Ccell%E5%B7%A6%E5%8F%B3%E6%8E%92%E7%89%88/
// * https://www.jianshu.com/p/28711ff1338b

// ## UICollectionViewFlowLayout 分页效果
// *  prepareLayout
// * func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint // return a point at which to rest after scrolling - for layouts that want snap-to-point scrolling behavior




/// 瀑布流
class WaterFallViewController: FlexboxBaseViewController, UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
//    lazy var layout = WaterFallFlowLayout().then { layout in
//        layout.delegate = self
//    }
    lazy var layout = SelfSizingFlowLayout().then { layout in
        layout.delegate = self
    }
                               
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then { collectionView in
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = .zero
        collectionView.register(FCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
                               
    var data = [String]()
                               
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return 100
    }
                               
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FCollectionCell
                                   
        cell.text = "index = \(indexPath.row)"
                                           
        return cell
    }
                               
    // MARK: UICollectionViewDelegate
                               
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did selected item \(indexPath)")
    }
                                   
}

extension WaterFallViewController: WaterFallLayoutDelegate, SelfSizingFlowLayoutDelegate {
    
    //       return CGFloat(arc4random_uniform(150) + 50)

    
    func waterFall(_ collectionView: UICollectionView, layout waterFallLayout: WaterFallFlowLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FCollectionCell
//                                   
//        cell.text = "index = \(indexPath.row)"
//        cell.contentView.flex.applyLayout(mode: .adjustHeight, preservingOrigin: true)
//        return cell.contentView.frame.size.height
        return 100
    }
    
    func heightForItem(at indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(150) + 50)
    }
    
}


private class FCollectionCell: GridCell {
    @UState var text: String?
                               
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .darkGray
    }

    override func bodyView() -> FlexboxView {
        Text($text)
            .fontSize(18)
            .textColor(.orange)
            .backgroundColor(.blue)
            .numberOfLines(0)
    }
                               
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
