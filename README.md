# *IPager*

## *Simple Flexible Pager for iOS built in Swift*

### *Installation* ###
<br/>
**Cocoapod** 
<br/>
```
pod 'IPager', :git => 'https://github.com/YousefAnsary/iPager.git
```
<br/>
**Swift Package Manager**
<br/>
```
.package(url: "https://github.com/YousefAnsary/iPager.git", from: "1.0")
```
<br/>
------------------------------------------------
### ***Customizations*** <br/>
### All you need is putting a UIView with the relevant constraints in your XIB/StoryBoard and make its type to `IPager` and customize as you want using Inspectable Properties in Interface Builder or using Code <br/> 
### ***Customizations*** <br/>
```
    @IBInspectable public var dotSize: CGSize // def is 8*8
    @IBInspectable public var selectedDotSize: CGSize // def is 12*12
    @IBInspectable public var spacing: CGFloat // def is 8
    @IBInspectable public var circularDot: Bool // def is true
    @IBInspectable public var tint: UIColor // def is gray
    @IBInspectable public var selectedTint: UIColor // def is blue
    @IBInspectable public var isPageSelectionEnabled // def is false
    public var didSelectedPageAt: ((Int) -> Void)?
    public var numberOfPages: Int // def is 3
    public var currentPage: Int // def is 0
```
