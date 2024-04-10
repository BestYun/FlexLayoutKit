//
//  USpace.swift
//  FlexLayoutKit
//
//  Created by yun on 2023/9/7.
//

import UIKit

public class Spacer: UIView, FlexboxLayout, UViewChain  {
    let spacing: CGFloat
    public init(_ spacing: CGFloat = 0) {
        self.spacing = spacing
        super.init(frame: .zero)
        flex.enabled(true)
        if spacing == 0 {
            flex.flex(1)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

///
public class HSpacer: UIView, FlexboxLayout, UViewChain  {
    let spacing: CGFloat
    public init(_ spacing: CGFloat = 0) {
        self.spacing = spacing
        super.init(frame: .zero)
        flex.enabled(true)
        if spacing == 0 {
            flex.flex(1)
        }else{
            flex.width(spacing)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class VSpacer: UIView, FlexboxLayout, UViewChain  {
    let spacing: CGFloat
    public init(_ spacing: CGFloat = 0) {
        self.spacing = spacing
        super.init(frame: .zero)
        flex.enabled(true)
        if spacing == 0 {
            flex.flex(1)
        }else{
            flex.height(spacing)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

