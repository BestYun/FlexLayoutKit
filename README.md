# FlexBoxUIKit

![Swift](https://img.shields.io/badge/Swift-5.4-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/FlexBoxUIKit.svg)](https://cocoapods.org/pods/FlexBoxUIKit)


基于[facebook/yoga](https://github.com/facebook/yoga)实现一个类似swiftui和Flutter的声明式UI框架

### Requirements
* iOS 10.0+
* Xcode 12.5
* Swift 5.4

### Installation
---
#### Cocoapods
```
pod 'FlexBoxUIKit', '~> 0.0.2'
以下可选
pod 'FlexBoxUIKit/SDWebImage'
pod 'FlexBoxUIKit/Kingfisher' #需要ios 12以上

```

### 特性
- [x] FlexBox布局, 支持**gap**,**rowGap**,**columnGap**
- [x] 声明式语法,类似**SwiftUI**,如**HStackView**、**VStackView**、**ZStackView**，类似Flutter中的**Row**、**Column**、**Stack**、**Wrap**
- [x] 自动计算**UITableViewCell** 高度
- [x] 支持**VScrollView**、**HScrollView**,自动计算**contentSize**
- [x] 使用**Wrap**轻松实现流式布局,超过屏幕时会自动换行
- [x] **Forin**和**if else** DSL支持
- [x] 数据驱动UI,更新数据后自动会更新UI
- [x] 支持百分比
- [x] 链式语法

### Usage 用法
#### Quick Start 快速开始
```swift
import FlexBoxUIKit  //1.导入FlexBoxUIKit
import UIKit

//2.继承FlexBaseViewController
class ViewController: FlexBaseViewController 
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //3.重写bodyView
    override func bodyView() -> UIView {
        return HStackView(mainAxis: .center, crossAxis: .center) {
            Text("Hello FlexBoxUIKit")
        }
        .flex(1)
    }
}

```

or
```swift
import FlexBoxUIKit

class ViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.flex.mainAxis(.center).crossAxis(.center).addItems {
            HStackView(mainAxis: .center, crossAxis: .center) {
                Text("Hello FlexBoxUIKit")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.flex.applyLayout()
    }
    
}
```

#### example1
<img src="https://github.com/BestYun/FlexBoxUIKit/blob/main/doc_imgs/example1.png" />

```swift
HStackView {
    ZStackView {
        ImageView()
            .backgroundColor(UIColor.gray.withAlphaComponent(0.5))
            .cornerRadius(8)
            .left(0)
            .bottom(0)
            .size(width: 50, height: 50)
       
        Text("1")
            .fontSize(12)
            .textColor(.white)
            .right(0)
            .top(0)
            .size(16)
            .cornerRadius(8)
            .backgroundColor(.red)
            .textAlignment(.center)
    }
    .size(58)
    .margin(.right, 8)
   
    VStackView(mainAxis: .spaceAround) {
        HStackView(crossAxis: .center) {
            Text("Leo")
                .fontSize(16, weight: .bold)
                .expanded()
            Text("13:30")
                .fontSize(12, weight: .medium)
                .textColor(.gray)
        }

        Text("hello,nice to meet you")
    }
    .height(50)
    .expanded()
    .margin(.top, 8)
}
.padding(.horizontal, 15)
.margin(.top, 100)

```

#### HStackView使用
```swift
HStackView {
    ImageView().size(40).cornerRadius(10).backgroundColor(.gray.withAlphaComponent(0.2))
    Space(10)
    Text("Leo").textColor(.orange).fontSize(16,weight: .medium)
}
```
#### VStackView使用
```swift
VStackView(crossAxis: .center) {
    ImageView().size(40).cornerRadius(10).backgroundColor(.gray.withAlphaComponent(0.2))
    Space(10)
    Text("Leo").textColor(.orange).fontSize(16,weight: .medium)
}
```
#### ZStackView使用
```swift
ZStackView {
    FlexContainerView(mainAxis: .center, crossAxis: .center){
        Text("99")
    }
    .cornerRadius(15)
    .backgroundColor(.red)
    .top(0)
    .right(0)
    .size(30)
}
.size(100)
.backgroundColor(.orange)
```

#### Wrap用法
```swift
let tags = ["tag1","tag2","tag3","tag4","tag5","tag6","tag7","tag8","tag9"]
//gap 是行间距和列间距简写
Wrap(gap: 10){
    for tag in tags {
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

```

#### ForIn用法
```swift
VScrollView {
    for i in 0...100 {
        FlexContainerView(mainAxis: .center, crossAxis: .center) {
            Text("\(i)")
        }
        .height(60)
        .backgroundColor(.orange.withAlphaComponent(0.1))
        .margin(.vertical,5)
    }
}
```

#### if else用法
```swift
let state = true
HStackView {
    if state {
        Text("true")
    }else{
        Text("false")
    }
}
```

#### @UState使用
```swift
@UState var count: String = "count"
var step: Int = 0 {
    didSet{
        count = "count = \(step)"
    }
}

VStackView(mainAxis: .center, crossAxis: .center) {
    Text($count).textColor(.black)
    Button("add").margin(.top,10).backgroundColor(.blue).onTap { [unowned self] in
        self.step = self.step + 1
        //修改内容后,要重新布局
        self.updateFlexLayout()
    }
}

```
#### 百分比
```swift
Text("FlexPercent").backgroundColor(.orange).width(20%).height(20%)

```

#### 自动计算UITableViewCell 动态高度
```swift
1)cell继承TableDynamicCell
2)UITableView的rowHeight设置为UITableView.automaticDimension

class CellItem: TableDynamicCell {
    override func bodyView() -> UIView {
        return VStackView {
            ...
        }
    }
}

UITableView().flex.expanded().apply {
    $0.delegate = self
    $0.dataSource = self
    $0.register(CellItem.self, forCellReuseIdentifier: "cellID")
    $0.estimatedRowHeight = 80
    $0.rowHeight = UITableView.automaticDimension
}

```


#### Modifier chain 链式语法
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

#### apply sugar 
> 只在UIView有效
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
---
### flexbox布局参考资料
* [reactnative文档中的flexbox](https://reactnative.cn/docs/flexbox)
* [yoga-布局引擎]( https://tbfungeek.github.io/2019/11/05/%E5%9C%A8%E9%A1%B9%E7%9B%AE%E4%B8%AD%E4%BD%BF%E7%94%A8Yoga-%E5%B8%83%E5%B1%80%E5%BC%95%E6%93%8E/)
* [mozilla CSS_flexible_box_layout](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_flexible_box_layout/Basic_concepts_of_flexbox)
* [阮一峰 Flex 布局教程：语法篇
](https://www.ruanyifeng.com/blog/2015/07/flex-grammar.html)

### FlexBox布局
<img src="https://github.com/BestYun/FlexBoxUIKit/blob/main/doc_imgs/flex_terms.png" />

* 主轴方向
* 布局方向 ltr,rtl
* 主轴方向子项分布 mainAxis
* 次轴方向子项分布 crossAxis
* 次轴方向多行子项分布 
* 子项自身分布

* flexbox文档
    * justifyContent
    * alignContent
    * alignItems
    * alignSelf
    * flexDirection
    * direction
    * flexWrap
    * position
    
### API
* margin padding left right top bottom 
* size width height minWidth
* flex 属性
* applyLayout
* markDirty
* sizeThatFits
* numberOfChildren
* isIncludedInLayout
* enabled
* display

### UI
* HStackView = Row
* VStackView = Column
* ZStackView = Stack 与Flutter和SwiftUI有差异,需要自己定义好size才有效果
* Wrap
* Text
* ImageView
* Space
* TextField
* TextView
* ScrollView
    * VScrollView
    * HScrollView
* TabCell
* TableDynamicCell
* CollectionCell



## Flex makeLayout
> 对于没有第二次封装的UIVIew,可以使用以下方法进行布局

```swift
UILabel().flex.makeLayout {
    $0.margin(.left, 10).margin(.top, 100)
}.apply {
    _ = $0.modifier
        .text("flex.makeLayout写法")
        .font(.systemFont(ofSize: 18))
        .textColor(.orange)
}
```

#### 动画
```
var blowUp = false
let boxView = FlexContainerView()

VStackView(mainAxis: .center, crossAxis: .center) {
    boxView.flex.size(100).modifier.backgroundColor(.blue).view
    
    Button("动画").size(width: 100, height: 30)
        .backgroundColor(.orange).margin(.top,10)
        .onTap { [unowned self] in
            UIView.animate(withDuration: 0.25, delay: 0) {
                self.boxView.flex.size(self.blowUp ? 200 : 100)
                self.updateFlexLayout()
                self.blowUp = !self.blowUp
            }
        }
    
}
```

## 更新内容




### Todo
* UITableView封装
    * 参考 https://github.com/josercc/SwiftTableViewGroup
* UICollection封装
* 测试

## 鸣谢
* https://github.com/MihaelIsaev/UIKitPlus
* https://blog.eppz.eu/declarative-uikit-with-10-lines-of-code/
* https://github.com/hmlongco/RxSwiftWidgets
* https://tech.youzan.com/-sheng-ming-shi-uikitzai-you-zan-mei-ye-de-shi-jian/
* https://github.com/sakiyamaK/DeclarativeUIKit
* https://github.com/hmlongco/Builder/tree/main
* https://github.com/hainayanda/Draftsman
* https://github.com/nicklockwood/layout  xml实现布局
* https://kazaimazai.com/swifty-uikit/
* https://github.com/KazaiMazai/SwiftyUIKit
* https://github.com/zhenglibao/FlexLib
* https://github.com/layoutBox/FlexLayout
* https://github.com/pujiaxin33/StackUI

## License
**FlexBoxUIKit** is under MIT license. See the [LICENSE](LICENSE) file for more info.
