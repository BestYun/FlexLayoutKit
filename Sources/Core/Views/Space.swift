//
//  Space.swift
//  FlexKit
//
//  Created by yun on 2023/9/7.
//

import UIKit


public class Space: UIView {
    let space: CGFloat
    public init(_ space: CGFloat = 0) {
        self.space = space
        super.init(frame: .zero)
        if space == 0 {
            flex.flex(1)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Space: FlexViewChain {}
extension Space: FlexLayout {}
