//
//  HGridFiexdedWidthViewController.swift
//  FlexLayoutKitExample
//
//  Created by yun on 2024/4/5.
//

import FlexLayoutKit
import UIKit

private let reuseIdentifier = "Cell"

/// 水平方向
class HGridDynamicWidthViewController: FlexboxBaseViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource
    
{
    lazy var layout = UICollectionViewFlowLayout().then { layout in
        //动态计算宽度,需要配置estimatedItemSize
        layout.estimatedItemSize = CGSize(width: 10, height: 80)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10 // 水平方向间距
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // UICollectionView的左右上下间距
        layout.scrollDirection = .horizontal // 方向
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
        collectionView
            .flex
            .expanded()
            .modifier
            .backgroundColor(.gray.withAlphaComponent(0.5))
    }
                                      
    // MARK: UICollectionViewDataSource
                                      
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
                                      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
                                      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FCollectionCell
                                          
        cell.text = "index \(indexPath.row) \(Array(repeating: "dynamic", count: indexPath.row/10).joined(separator: "-")) "
                                                  
        return cell
    }
                                      
    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did selected item \(indexPath)")
    }
                                      
    
}

private class FCollectionCell: GridCell {
    override var isDynamicHeight: Bool { true }
    override var scrollDirection: UICollectionView.ScrollDirection { .horizontal }
    @UState var text: String?
                                   
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func bodyView() -> FlexboxView {
        Text($text).expanded().backgroundColor(.orange).cornerRadius(10).padding(.horizontal,20)
    }
                                      
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
