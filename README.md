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
- [Credits](#credits)
- [License](#license)

## Overview

LayoutBuilder is a set of structures, extensions, and operators that allows you to create NSLayoutConstraint using a linear equation. For example, if you want to create horizontal relation between a button and its superview, you need to write a simple line of code:
````swift
let constraint = button.layout(.leading) = 20
````
The result of this line will be NSLayoutConstraint. You can use Layout initializer with closure parameter that uses an internal ResultBuilder (ex FunctionBuilder) to activate constraints: 
````swift
Layout {
    button.layout(.leading) == 20
}
````
It’s important to note that the equations shown in Note represent equality, not assignment.
There are many ways to create constraints through a linear equation. We will consider them in the description below.

## Features
- Clear linear equation way to creating NSLayoutConstraint.
- Intuitive set of operators for using in the equation.
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

To integrate SnapKit into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

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
There is possible not to use unnecessary parameters on the right side of the equation if your context implies it.

### Operatos
There are multiple operators for NSLayoutConstraint creation. They can be divided into two groups: creation and modification operators. 
Creation operators are the relationship operators at the same time and expects `firstItem` and` firstAttribute` at the left side and `secondItem` and` secondAttribute` at the right side. Also, you can use modification operators on the right side. Still, you need use them in the direct sequence: multiplier `*` -> constant `+` -> priority `!`. Finally, you not able to use the multiplier operator if you don't use item or item.attribute in the equation.

#### Creation operators
| Operator | Description |
| :-: | :--- |
| `==` | EQUAL operator. Use `==` after call `layout(_ attribute:)` method in the first view |
| `>=` | GREATER THAN OR EQUAL relation operator. Use `==` after call `layout(_ attribute:)` method in the first view |
| `<=` | LESS THAN OR EQUAL relation operator. Use `==` after call `layout(_ attribute:)` method in the first view |

#### Modification operators
| Operator | Description |
| `+` | Operator to add constant to relation. Use after you call `layout(_ attribute:)` method in the second view |
| `-` | Operator to add inversed constant to relation. Use after you call `layout(_ attribute:)` method in the second view |
| `*` | Operator to add multiplier to relation. Use before you call `layout(_ attribute:)` method in the second view |
| `!` | Operator to add priority to the constraint. Use after your constraint vas created |

Call `Layout` initializer to apply constraints. Layout initializer's single parameter is a closure that uses Result Builder **LayoutBuilder** to accept multiple NSLayoutConstraints parameters.

### Examples

1. Create redView and blueView properties and add them as subviews to the parent view
````swift
let redView = UIView()
redView.backgroundColor = .red
        
let blueView = UIView()
blueView.backgroundColor = .blue
        
view.addSubview(redView)
view.addSubview(blueView)
````
2. Create constraints
````swift
//1
let topConstraint = redView.layout(.top) == view.layout(.centerY) + 50 
//2
let leadingConstraint = redView.layout(.leading) == 20
//3
let centerXConstraint = (redView.layout(.centerX) == 1/2 * view.layout(.centerX) + 10) ! .defaultLow
//4
let heightConstraint = redView.layout(.height) >= 33
````
So, we created 4 constraints. Top Constraint (1) was created using the relation between two views and adding constant to this relation. Leading Constraint (2) was created using the relation berween view and constant. Such an entry means that Red View automatically applies relation to its superview and adds constant. Center X Constraint (3) was created using the relation between two views, multiplier, constant, and priority. Height Constraint (4) was created using greaterThanOrEqual relation between view and constant. 

3. Apply constraints 
````swift
Layout {
    topConstraint
    leadingConstraint
    centerXConstraint
    heightConstraint
}
````

Also you can create constraints directly inside Layout body
````swift
Layout {
    redView.layout(.top) == view.layout(.centerY) + 50
    redView.layout(.leading) == 20
    (redView.layout(.centerX) == 1/2 * view.layout(.centerX) + 10) ! .defaultLow
    redView.layout(.height) >= 33
}
````

And finaly, you can create and use properties inside Layout body
````swift
Layout {
    redView.layout(.top) == view.layout(.centerY) + 50
    redView.layout(.leading) == 20
    (redView.layout(.centerX) == 1/2 * view.layout(.centerX) + 10) ! .defaultLow
            
    let heightConstraint = redView.layout(.height) >= 33            
    heightConstraint
}
````

4. Using conditional statements inside Layout body
````
Layout {
    if needTopConstraint {
        redView.layout(.top) == view.layout(.centerY) + 50
    } else {
        redView.layout(.centerY) == view.layout(.centerY)
    }
            
    redView.layout(.leading) == 20
            
    if let blueView = blueView {
        blueView.layout(.leading) == 20
    }
}
````
You can use conditional statements and optional chaining inside Layout body. It provides a really flexible way to constraint building.

## Credits

- Ihor Malovanyi ([@multimediasuite](https://www.facebook.com/multimediasuite))

## License

LayoutBuilder is released under the MIT license. See LICENSE for details.
