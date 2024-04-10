//
//  WaterFallFlowLayout.swift
//  FlexLayoutKitExample
//
//  Created by yun on 2024/4/5.
//

import UIKit

protocol WaterFallLayoutDelegate: AnyObject {
    
    func waterFall(_ collectionView: UICollectionView, layout waterFallLayout: WaterFallFlowLayout, heightForItemAt indexPath: IndexPath) -> CGFloat

}

class WaterFallFlowLayout: UICollectionViewLayout {
    // https://juejin.cn/post/6844903575441637389?searchId=20240405171041254EDFB1442A61513BDF

    weak var delegate: WaterFallLayoutDelegate?

    // 2
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 6

    // 3
    private var cache: [UICollectionViewLayoutAttributes] = []

    // 4
    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    // 5
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        // 1
        guard cache.isEmpty,let collectionView = collectionView else {
            return
        }
        // 2
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)

        // 3
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

            // 4
            let itemHeight = delegate?.waterFall(collectionView, layout: self, heightForItemAt: indexPath) ?? 0

            let height = cellPadding * 2 + itemHeight

            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height

            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
      var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
      
      // Loop through the cache and look for items in the rect
      for attributes in cache {
        if attributes.frame.intersects(rect) {
          visibleLayoutAttributes.append(attributes)
        }
      }
      return visibleLayoutAttributes
    }

    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            return cache[indexPath.item]
    }
    
    override func invalidateLayout() {
        cache = []
        contentHeight = 0
        super.invalidateLayout()
    }

}



protocol SelfSizingFlowLayoutDelegate: AnyObject {
    func heightForItem(at indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}

class SelfSizingFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Configurable/public properties
    public var itemsPerRow = 2 {
        didSet {
            // lazy way out, but outside the scope of this project (for now)
            self.collectionView?.reloadData()
        }
    }
    
    public var distanceBetweenRows: CGFloat = 5 {
        didSet {
            // lazy way out, but outside the scope of this project (for now)
            self.collectionView?.reloadData()
        }
    }
    
    fileprivate var calculatedContentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - insets.left - insets.right
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.calculatedContentWidth, height: self.calculatedContentHeight)
    }
    
    // MARK: - General required stuff
    
    public weak var delegate: SelfSizingFlowLayoutDelegate?
    
    override init() {
        super.init()
//        self.estimatedItemSize = CGSize(width: 300, height: 10)
        self.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.itemSize = UICollectionViewFlowLayout.automaticSize
        self.minimumInteritemSpacing = 15
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private helpers
    
    private var calculatedAttributes: [UICollectionViewLayoutAttributes] = []
    private var calculatedContentHeight: CGFloat = 0
    
    private var usableWidthPerItem: CGFloat {
        get {
            // how much width can we use in total right now?
            let contentInsets = self.collectionView!.contentInset.left + self.collectionView!.contentInset.right
            let sectionInsets = self.sectionInset.left + self.sectionInset.right
            
            let usableWidth = self.collectionView!.frame.width - contentInsets - sectionInsets - 2
            let intercardSpacingPerRow = (CGFloat(self.itemsPerRow) - 1) * self.minimumInteritemSpacing
            let usableWidthPerCard = (usableWidth - intercardSpacingPerRow) / CGFloat(self.itemsPerRow)
            return usableWidthPerCard
        }
    }
    
    // used as to avoid calculating heights more than necessary
    private var itemHeights: [CGFloat?] = []
    
    // used for animations
    private var insertingPaths: [IndexPath] = []
    private var deletingPaths: [IndexPath] = []
}

extension SelfSizingFlowLayout {
    // whenever our layout is deemed invalid, we need to relayout our collection and store the information
    // later collection view lifecycle methods will query for different things, but they'll pull from the
    // calculations we do here
    override func prepare() {
        // don't recalculate everything if we haven't cleared our cache
        guard self.calculatedAttributes.isEmpty, let collectionView = collectionView,let delegate = delegate else {
            return
        }
        calculatedAttributes.removeAll()
        calculatedContentHeight = 0
        let itemWidth = self.usableWidthPerItem
        
        // we already know where all of our items lie on the x-axis based on their column number alone,
        // so we can make this a let
        let xCoordinates: [CGFloat] = (0 ..< self.itemsPerRow).map { CGFloat($0) * (itemWidth + self.minimumInteritemSpacing) + self.sectionInset.left }
        
        // our y-coordinates vary depending on previous height calculations, so this array needs to be
        // mutable. this array will keep track of our last-used height for each column, which we'll
        // need to know when setting the y-coordinates for the next row
        var lastUsedYCoordinateForSections: [CGFloat] = Array(repeating: 0, count: self.itemsPerRow)
        
        var currentColumn = 0
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let path = IndexPath(item: item, section: 0)
            
            let itemHeight = delegate.heightForItem(at: path, withWidth: itemWidth)
            let heightWithSpacing = 2 * self.distanceBetweenRows + itemHeight
            
            // we want our frame to account for extra vertical spacing, but the inset frame is what's actually used for our cell
            let frameWithSpacing = CGRect(x: xCoordinates[currentColumn], y: lastUsedYCoordinateForSections[currentColumn], width: itemWidth, height: heightWithSpacing)
            let insetFrame = frameWithSpacing.insetBy(dx: 0, dy: self.distanceBetweenRows)
            
            // build our attributes that actually store the salient info
            let attributes = UICollectionViewLayoutAttributes(forCellWith: path)
            attributes.frame = insetFrame
            self.calculatedAttributes.append(attributes)
            
            // did our latest cell make our collection bigger? update if so
            self.calculatedContentHeight = max(self.calculatedContentHeight, frameWithSpacing.maxY)
            lastUsedYCoordinateForSections[currentColumn] = lastUsedYCoordinateForSections[currentColumn] + heightWithSpacing
            
            currentColumn = currentColumn < (self.itemsPerRow - 1) ? (currentColumn + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // once we're here, we've already been through the prepare() step, so we can just loop over our
        // calculations and return the relevant ones
        return self.calculatedAttributes.compactMap { return $0.frame.intersects(rect) ? $0 : nil }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.calculatedAttributes[indexPath.item]
    }
}



