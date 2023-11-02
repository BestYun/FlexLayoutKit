//
//  LivePreview.swift
//  FlexKit
//
//  Created by yun on 2023/9/1.
//


#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct LivePreView : UIViewRepresentable {
    
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
    
    func makeUIView(context: Context) -> UIView {
        let view = CustomView()
        return view
    }
}

@available(iOS 13.0, *)
struct LivePreViewr_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LivePreView()
        }
    }
}

#endif


import FlexBoxUIKit
class CustomView:UIView{
    override init(frame: CGRect) {
        super.init(frame: .zero)
//        backgroundColor = .blue
        flex.enabled(true)
        flex.addItems {
            HStackView {
                ZStackView {
                    ImageView()
                        .backgroundColor(.orange)
                        .cornerRadius(16)
                        .left(0)
                        .top(0)
                        .right(0)
                        .bottom(0)
                }
                .margin(.right, 12)
                .size(width: 60, height: 60)
                
                VStackView(mainAxis: .spaceAround) {
                    HStackView (crossAxis: .center){
                        Text("Leo")
                            .fontSize(16, weight: .bold)
                            .flex(1)
                        Text("13:30")
                            .fontSize(12, weight: .medium)
                            .textColor(.gray)
                    }

                    Text("hello,nice to meet you")
                }
                .flex(1)
            }.padding(.horizontal, 15)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flex.applyLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
