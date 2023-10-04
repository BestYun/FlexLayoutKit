//
//  CollectionViewControllerDemo.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/3.
//

import UIKit
import FlexUIKit

private let reuseIdentifier = "Cell"

class CollectionViewControllerDemo: FlexBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bodyView() -> UIView {
        let layout = UICollectionViewFlowLayout()
        
        let size = (UIScreen.main.bounds.size.width - 10 * 3)/3
        
//        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        self.collectionView!.register(FCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        return collectionView
            .flex
            .margin(.horizontal,0)
            .margin(.top,0)
            .expanded()
            .view
    }


    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 1000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FCollectionCell
    
        cell.text = "text \(indexPath.row*1000)"
        
    
        return cell
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

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
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .darkGray
    }
    override func bodyView() -> UIView {
        return textLabel.flex.margin(.top,10).margin(.left,5).view
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
