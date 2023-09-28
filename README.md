# FlexUIKit
类似swiftui和Flutter的声明式UI框架

### Requirements
* iOS 9.0+
* Xcode 12.5
* Swift 5.4

### Installation
---
#### Cocoapods
```
pod 'FlexUIKit', :git => 'https://github.com/BestYun/FlexUIKit.git', :tag => '0.0.1'
```

### Usage 用法
#### Quick Start 快速开始
```swift
import FlexUIKit
import UIKit

class ViewController: FlexBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func bodyView() -> UIView {
        return HStackView(mainAxis: .center, crossAxis: .center) {
            Text("Hello FlexUIKit")
        }
        .flex(1)
    }
}

```

### Modifier chain 链式语法
```swift
UILabel()
    .modifier
    .text("链式语法")
    .textColor(.orange)
    .font(.systemFont(ofSize: 16))
    .view
```
等同于
```swift
let label = UILabel()
label.text = "test apply"
label.font = .systemFont(ofSize: 16)
label.textColor = .orange
```

### apply sugar 只在UIView有效
```swift
UIView(frame: CGRect(x: 10, y: 100, width: 60, height: 60)).apply {
    $0.backgroundColor = .blue
    $0.layer.cornerRadius = 30
    $0.clipsToBounds = true
}

UILabel().apply { label in
    label.text = "test apply"
    label.font = .systemFont(ofSize: 16)
    label.textColor = .orange
}

```
等同于
```swift
let blueView = UIView(frame: CGRect(x: 10, y: 100, width: 60, height: 60))
blueView.backgroundColor = .blue
blueView.layer.cornerRadius = 30
blueView.clipsToBounds = true


let label = UILabel()
label.text = "test apply"
label.font = .systemFont(ofSize: 16)
label.textColor = .orange
```