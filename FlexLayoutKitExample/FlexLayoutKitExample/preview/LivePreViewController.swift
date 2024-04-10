//
//  LivePreViewController.swift
//  FlexKit
//
//  Created by yun on 2023/9/1.
//

#if canImport(SwiftUI) && DEBUG
    import SwiftUI

    @available(iOS 13.0, *)
    struct DeclarativeViewController_Wrapper: UIViewControllerRepresentable {
        typealias ViewController = HelloFlexUIKitViewController

        func makeUIViewController(context _: Context) -> ViewController {
            let vc = ViewController()
            return vc
        }

        func updateUIViewController(_: ViewController, context _: Context) {}
    }

    @available(iOS 13.0, *)
    struct DeclarativeViewController_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                DeclarativeViewController_Wrapper()
            }
        }
    }
#endif
