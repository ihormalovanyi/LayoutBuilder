//
//  ConstraintGroup.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 10.05.2021.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

public protocol ConstraintsGroup {

    var constraints: [NSLayoutConstraint] { get }

}

extension NSLayoutConstraint: ConstraintsGroup {

    public var constraints: [NSLayoutConstraint] { [self] }

}

extension Array: ConstraintsGroup where Element == NSLayoutConstraint {

    public var constraints: [NSLayoutConstraint] { self }

}
