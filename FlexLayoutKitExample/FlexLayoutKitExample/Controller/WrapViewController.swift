//
//  WrapViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/6.
//

import UIKit
import FlexLayoutKit

class WrapViewController: FlexboxBaseViewController {

    private let tagNames: [String] = [
        "Swift",
        "iOS",
        "XCode",
        "Objective-C",
        "UIKit",
        "SwiftUI",
        "Core Data",
        "Realm",
        "Combine",
        "RxSwift",
        "Clean Architecture",
        "MVVM",
        "MVC",
        "MVP",
        "VIPER",
        "TCA",
        "Algorithm",
        "Data Structure"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @FlexboxViewBuilder override func bodyView() -> [FlexboxView] {
        HWrap(spacing: 10){
            for tag in tagNames {
                Text(tag)
                    .backgroundColor(.gray.withAlphaComponent(0.5))
                    .textAlignment(.center)
                    .cornerRadius(15)
                    .padding(.horizontal,10)
                    .height(30)
                    .onTap {
                        print(tag)
                    }
            }
        }
        .margin(.top, 100)
        .margin(.horizontal, 15)
    }
    
    
}
