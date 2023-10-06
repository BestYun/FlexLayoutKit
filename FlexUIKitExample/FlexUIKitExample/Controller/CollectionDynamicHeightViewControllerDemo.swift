//
//  CollectionViewControllerDemo.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/3.
//

import FlexUIKit
import UIKit

private let reuseIdentifier = "Cell"

private let width = (UIScreen.main.bounds.size.width - 10 * 2) / 3

/// 动态宽高
class CollectionDynamicHeightViewControllerDemo: FlexBaseViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    var collectionView: UICollectionView!
    
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...100 {
            
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
    
        
    }
    
    override func bodyView() -> UIView {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = CGSize(width: width, height: width)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
                
        self.collectionView!.register(FCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        return collectionView
            .flex
            .margin(.horizontal, 0)
            .margin(.top, 0)
            .expanded()
            .view
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(arc4random_uniform(150) + 50)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let size = cell.contentView.flex.sizeThatFits(with: CGSize(width: width, height: CGFloat.nan))
//        print("width = \(width) height = \(height)")
        return  size//CGSize(width: width, height: height)
    }
}

private class FCollectionCell: CollectionDynamicCell {
    var text: String? {
        didSet {
            textLabel.flex.markDirty()
            textLabel.text = text
        }
    }
    
    let textLabel = UILabel().apply {
        $0.text = "text----"
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .orange
        $0.backgroundColor = .blue
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .darkGray
        
    }

    override func bodyView() -> UIView {
        return textLabel.flex.expanded().view
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
