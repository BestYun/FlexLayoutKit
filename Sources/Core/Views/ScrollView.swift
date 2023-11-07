//
//  ScrollView.swift
//  FlexKit
//
//  Created by yun on 2023/8/20.
//

import UIKit

public class ScrollView: UIScrollView {
    public var contentView = UIView()

    public init(direction: FlexDirection = .column, mainAxis: MainAxisAlignment = .start, crossAxis: CrossAxisAlignment = .stretch, space: CGFloat = 0, @FlexViewBuilder subviews: () -> [UIView]) {
        super.init(frame: .zero)
//        if #available(iOS 11.0, *) {
//            self.contentInsetAdjustmentBehavior = .never
//        } else {
//            //UIViewController中 automaticallyAdjustsScrollViewInsets = false
//        }

        // 默认不显示滚动条
//        showsVerticalScrollIndicator = false
//        showsHorizontalScrollIndicator = false
        // 这个需要配置
        flex.direction(direction)

        contentView
            .flex
            .direction(direction)
            .mainAxis(mainAxis)
            .crossAxis(crossAxis)
            .gap(space)
            .addItems(subviews: subviews)

        if direction == FlexDirection.row || direction == FlexDirection.rowReverse {
            alwaysBounceHorizontal = true
        } else {
            alwaysBounceVertical = true
        }

        addSubview(contentView)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
//        if showsVerticalScrollIndicator || showsHorizontalScrollIndicator {
//            subviews.forEach { item in
//                let typeStr = "\(type(of: item))"
//                if typeStr == "_UIScrollViewScrollIndicator" {
//                    item.flex.isIncludedInLayout(false)
//                }
//            }
//        }
        let size = contentView.frame.size
        contentSize = CGSize(width: size.width, height: size.height)
    }

    public func addItems(@FlexViewBuilder subviews: () -> [UIView]) {
        let subviews = subviews()

        subviews.forEach { item in
            item.flex.enabled(true)
            contentView.addSubview(item)
        }
        flex.applyLayout()
    }
}

public class HScrollView: ScrollView {
    public init(mainAxis: MainAxisAlignment = .start, crossAxis: CrossAxisAlignment = .stretch, space: CGFloat = 0, @FlexViewBuilder subviews: () -> [UIView]) {
        super.init(direction: .row, mainAxis: mainAxis, crossAxis: crossAxis, space: space, subviews: subviews)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class VScrollView: ScrollView {
    public init(mainAxis: MainAxisAlignment = .start, crossAxis: CrossAxisAlignment = .stretch, space: CGFloat = 0, @FlexViewBuilder subviews: () -> [UIView]) {
        super.init(direction: .column, mainAxis: mainAxis, crossAxis: crossAxis, space: space, subviews: subviews)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ScrollView: FlexViewChain {}
extension ScrollView: FlexLayout {}

public extension ScrollView {
    @discardableResult func contentOffset(_ contentOffset: CGPoint) -> Self {
        self.contentOffset = contentOffset
        return self
    }

    @discardableResult func contentSize(_ contentSize: CGSize) -> Self {
        self.contentSize = contentSize
        return self
    }

    @discardableResult func contentInset(_ contentInset: UIEdgeInsets) -> Self {
        self.contentInset = contentInset
        return self
    }

    @available(iOS 11.0, *)
    @discardableResult func contentInsetAdjustmentBehavior(_ contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior) -> Self {
        self.contentInsetAdjustmentBehavior = contentInsetAdjustmentBehavior
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult func automaticallyAdjustsScrollIndicatorInsets(_ automaticallyAdjustsScrollIndicatorInsets: Bool) -> Self {
        self.automaticallyAdjustsScrollIndicatorInsets = automaticallyAdjustsScrollIndicatorInsets
        return self
    }

    @discardableResult func delegate(_ delegate: UIScrollViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult func isDirectionalLockEnabled(_ isDirectionalLockEnabled: Bool) -> Self {
        self.isDirectionalLockEnabled = isDirectionalLockEnabled
        return self
    }

    @discardableResult func bounces(_ bounces: Bool) -> Self {
        self.bounces = bounces
        return self
    }

    @discardableResult func alwaysBounceVertical(_ alwaysBounceVertical: Bool) -> Self {
        self.alwaysBounceVertical = alwaysBounceVertical
        return self
    }

    @discardableResult func alwaysBounceHorizontal(_ alwaysBounceHorizontal: Bool) -> Self {
        self.alwaysBounceHorizontal = alwaysBounceHorizontal
        return self
    }

    @discardableResult func isPagingEnabled(_ isPagingEnabled: Bool) -> Self {
        self.isPagingEnabled = isPagingEnabled
        return self
    }

    @discardableResult func isScrollEnabled(_ isScrollEnabled: Bool) -> Self {
        self.isScrollEnabled = isScrollEnabled
        return self
    }

    @discardableResult func showsVerticalScrollIndicator(_ showsVerticalScrollIndicator: Bool) -> Self {
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        return self
    }

    @discardableResult func showsHorizontalScrollIndicator(_ showsHorizontalScrollIndicator: Bool) -> Self {
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        return self
    }

    @discardableResult func indicatorStyle(_ indicatorStyle: UIScrollView.IndicatorStyle) -> Self {
        self.indicatorStyle = indicatorStyle
        return self
    }

    @available(iOS 11.1, *)
    @discardableResult func verticalScrollIndicatorInsets(_ verticalScrollIndicatorInsets: UIEdgeInsets) -> Self {
        self.verticalScrollIndicatorInsets = verticalScrollIndicatorInsets
        return self
    }

    @available(iOS 11.1, *)
    @discardableResult func horizontalScrollIndicatorInsets(_ horizontalScrollIndicatorInsets: UIEdgeInsets) -> Self {
        self.horizontalScrollIndicatorInsets = horizontalScrollIndicatorInsets
        return self
    }

    @discardableResult func scrollIndicatorInsets(_ scrollIndicatorInsets: UIEdgeInsets) -> Self {
        self.scrollIndicatorInsets = scrollIndicatorInsets
        return self
    }

    @discardableResult func decelerationRate(_ decelerationRate: UIScrollView.DecelerationRate) -> Self {
        self.decelerationRate = decelerationRate
        return self
    }

    @discardableResult func indexDisplayMode(_ indexDisplayMode: UIScrollView.IndexDisplayMode) -> Self {
        self.indexDisplayMode = indexDisplayMode
        return self
    }

    @discardableResult func delaysContentTouches(_ delaysContentTouches: Bool) -> Self {
        self.delaysContentTouches = delaysContentTouches
        return self
    }

    @discardableResult func canCancelContentTouches(_ canCancelContentTouches: Bool) -> Self {
        self.canCancelContentTouches = canCancelContentTouches
        return self
    }

    @discardableResult func minimumZoomScale(_ minimumZoomScale: CGFloat) -> Self {
        self.minimumZoomScale = minimumZoomScale
        return self
    }

    @discardableResult func maximumZoomScale(_ maximumZoomScale: CGFloat) -> Self {
        self.maximumZoomScale = maximumZoomScale
        return self
    }

    @discardableResult func zoomScale(_ zoomScale: CGFloat) -> Self {
        self.zoomScale = zoomScale
        return self
    }

    @discardableResult func bouncesZoom(_ bouncesZoom: Bool) -> Self {
        self.bouncesZoom = bouncesZoom
        return self
    }

    @discardableResult func scrollsToTop(_ scrollsToTop: Bool) -> Self {
        self.scrollsToTop = scrollsToTop
        return self
    }

    @discardableResult func keyboardDismissMode(_ keyboardDismissMode: UIScrollView.KeyboardDismissMode) -> Self {
        self.keyboardDismissMode = keyboardDismissMode
        return self
    }

    @available(iOS 10.0, *)
    @discardableResult func refreshControl(_ refreshControl: UIRefreshControl?) -> Self {
        self.refreshControl = refreshControl
        return self
    }
}
