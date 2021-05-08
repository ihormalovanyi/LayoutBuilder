<img src="https://ihor.pro/wp-content/uploads/2021/05/layoutbuilder_image_header-2.jpg" alt="" />

LayoutBuilder is an operator-based layout relationship builder. It allows you to create constraints programmatically simpler and more elegant than ever. 
And it is very flexible.

![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-blue)
[![Swift 5.4](https://img.shields.io/badge/Swift-5.4-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![MIT](https://img.shields.io/badge/license-MIT-green)](https://github.com/multimediasuite/LayoutBuilder/blob/master/LICENSE)

## Contents
- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Explanation](#explanation)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

## Overview

LayoutBuilder is a set of structures, extensions, and operators that allows you to create NSLayoutConstraint using a linear equation. For example, if you want to create horizontal relation between a button and its superview, you need to write a simple line of code:
````swift
let constraint = button.layout(.leading) == 20
````
The result of this line will be NSLayoutConstraint. You can use Layout initializer with closure parameter that uses an internal ResultBuilder (ex FunctionBuilder) to activate constraints: 
````swift
Layout {
    button.layout(.leading) == 20
}
````
There are many ways to create constraints through a linear equation. We will consider them in the description below.

## Features
- Clean linear equation way to creating NSLayoutConstraint.
- An intuitive set of operators for using in the equation.
- Flexible combinable parameters.
- Simple constraints activation.
- Ability to use conditional expressions in the constraint activation closure.

## Requirements

- iOS 9.0+ / Mac OS X 10.10+
- Xcode 12.5+
- Swift 5.4+

## Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/layoutbuilder). (Tag 'layoutbuilder')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/layoutbuilder).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

### CocoaPods

[CocoaPods](#https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:
```
$ gem install cocoapods
```
To integrate **LayoutBuilder** into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
  pod 'LayoutBuilder'
end
```
Then, run the following command:
```
$ pod install
```

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

> Xcode 12.5+ is required to build LayoutBuilder using Swift Package Manager.

To integrate LayoutBuilder into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/multimediasuite/LayoutBuilder.git", .upToNextMajor(from: "0.5.1"))
]
```

Or add dependency manually in Xcode. File -> Swift Packages -> Add Package Dependency... then enter the package URL 'https://github.com/multimediasuite/LayoutBuilder.git' and click Next button.

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate **LayoutBuilder** into your project manually.

## Explanation

In Apple's documentation, each constraint is a linear equation with the following format:
````
item1.attribute1 = multiplier × item2.attribute2 + constant
````
This is a convenient formula, and I put it at the heart of the framework with one more addition: priority operator `!`. So in LayoutBuilder framework final core equation has the following format: 
````
item1.attribute1 = multiplier × item2.attribute2 + constant ! priority
````
> **Note**: It’s important to note that the equations shown above represent equality, not assignment.

There is possible not to use unnecessary parameters on the right side of the equation if your context implies it.

You must use an item with attribute at the left side of equation, and at the right side, you can use an item or item with attribute.
Item is `UIView` or `NSView`. If you want to create an item with attribute, use `layout(_ :)` method of item: 
````swift
var itemWithAttribute = view.layout(.leading) //The result is LayoutItem object that contains view and attribute
````
> **Note**: If you use an item without an attribute on the right side, the second attribute will be the same as the first attribute.

### Operators
There are multiple operators for NSLayoutConstraint creation. They can be divided into two groups: creation and modification operators. 
Creation operators are the relationship operators at the same time and expects `firstItem` and` firstAttribute` at the left side and `secondItem` and` secondAttribute` at the right side. Also, you can use modification operators on the right side. Still, you need use them in the direct sequence: multiplier `*` -> constant `+` -> priority `!`. Finally, you not able to use the multiplier operator if you don't use item or item.attribute in the equation.

#### Creation operators
| Operator | Description |
| :-: | :--- |
| `==` | Equal operator. The result constraint requires the first attribute to be exactly equal to the modified second attribute. |
| `>=` | Greater than or equal relation operator. The result constraint requires the first attribute to be greater than or equal to the modified second attribute. |
| `<=` | Less than or equal operator. The result constraint requires the first attribute to be less than or equal to the modified second attribute. |

#### Modification operators
| Operator | Description |
| :-: | :--- |
| `+` | Constant operator. Expects item or item with attribute at the left side and floating-point value at the right side. `0` by default. |
| `-` | Negative Constant operator. Expects item or item with attribute at the left side and floating-point value at the right side. `0` by default. |
| `*` | Multiplier operator. Expects floating-point value at the left side and item or item with attribute at the right side. `1` by default. |
| `!` | Priority operator. Expects item or item with attribute or constant at the left side and Priority value at the right side. `.required` by default. |

> **Note**: You can use floating-point value at the right side as the first parameter without multiplier operator and item or item with attribute. This will mean that the second attribute will be the same as the first attribute, and the superview of the first item will set as the second item (except when the first attribute is `.width` or `.height`).

Call `Layout` initializer to activate constraints. Layout initializer's single parameter is a closure that uses Result Builder to accept multiple NSLayoutConstraints parameters. You can use conditional statements inside the closure. 

### Usage

#### Usage listing
````swift
import UIKit
import LayoutBuilder

final class ViewController: UIViewController {
    
    lazy var redView = UIView()
    lazy var blueView = UIView()
    
    var isBlueViewSizeEqualToRedView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(redView)
        view.addSubview(blueView)
        
        redView.backgroundColor = .red
        blueView.backgroundColor = .blue
        
        Layout {
            redView.layout(.height) == 100
            redView.layout(.width) == 0.5 * view
            redView.layout(.centerX) == 0
            redView.layout(.centerY) == view
            
            if isBlueViewSizeEqualToRedView {
                blueView.layout(.width) == redView
                blueView.layout(.height) == redView
            } else {
                blueView.layout(.width) >= 0.2 * redView + 10
                blueView.layout(.height) == redView.layout(.width)
            }
            
            blueView.layout(.bottom) == view.layout(.centerY) + 100
            blueView.layout(.centerX) == 0
        }
    }
    
}
````

#### Common constraint creation listing 
````swift
//RedView.height EQUAL to CONSTANT 40
redView.layout(.height) == 40

//RedView.leading EQUAL to BlueView.trailing with CONSTANT 8
redView.layout(.leading) == blueView.layout(.trailing) + 8

//RedView.width EQUAL to BlueView.width with MULTIPLIER 0.5 and CONSTANT 20
redView.layout(.width) == 0.5 * blueView + 20

//RedView.centerY EQUAL to RedView.Superview
redView.layout(.centerY) == 0

//BlueView.width GREATER THAN OR EQUAL to RedView.width with PRIORITY defaultLow
blueView.layout(.width) >= redView ! .defaultLow

//BlueView.centerX LESS THAN OR EQUAL to BlueView.Superview with CONSTANT 20 and PRIORITY defaultHigh
blueView.layout(.centerX) <= 20 ! .defaultHigh

//RedView.centerX EQUAL to BlueView.top with MULTIPLIER 0.8 and CONSTANT 16 and PRIORITY defaultLow
redView.layout(.centerX) == 0.8 * blueView.layout(.top) + 16 ! .defaultLow

//etc...
````

## Credits

- Ihor Malovanyi ([@multimediasuite](https://www.facebook.com/multimediasuite))

## License

LayoutBuilder is released under the MIT license. See LICENSE for details.
