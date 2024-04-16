//
//  CollectionViewControllerDemo.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/3.
//

import FlexLayoutKit
import UIKit

private let reuseIdentifier = "Cell"

private let width = (UIScreen.main.bounds.size.width - 10 * 1 - 10 * 2) / 2

/// 垂直方向的:固定宽高
class CollectionFixedHeightViewControllerDemo: FlexboxBaseViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    
    lazy var layout =  UICollectionViewFlowLayout().then { layout in
        //固定宽高,方法一:可以通过layout.itemSize
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10 // 水平方向间距
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //UICollectionView的左右上下间距
        layout.scrollDirection = .vertical //方向
        
    }
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then { collectionView in
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        
        view.flex
            .addItems(subviews: bodyView())
    }
    
    @FlexboxViewBuilder  func bodyView() -> [FlexboxView] {
        collectionView.flex.expanded()
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FCollectionCell
        
        cell.text = "index \(indexPath.row)"
                
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did selected item \(indexPath)")
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //固定宽高,方法二:可以通过UICollectionViewDelegateFlowLayout中的sizeForItemAt
        
        if indexPath.row == 4 {
            return CGSize(width: UIScreen.main.bounds.size.width - 10*2, height: width)
        }
        return CGSize(width: width, height: width)
    }
}


private class FCollectionCell: CollectionCell {
    @UState var text: String?
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func bodyView() -> FlexboxView {
//        textLabel.flex.expanded()
        Text($text).expanded().backgroundColor(.white).cornerRadius(10)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
