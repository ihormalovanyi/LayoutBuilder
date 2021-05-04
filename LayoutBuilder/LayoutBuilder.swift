//
//  LayoutBuilder.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 04.05.2021.
//

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

//https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ProgrammaticallyCreatingConstraints.html#//apple_ref/doc/uid/TP40010853-CH16-SW1
//Example: item1.attribute = multiplier * item2.attrubute + constant

#if os(macOS)
public typealias LayoutParts = (view: NSView, attribute: NSLayoutConstraint.Attribute, constant: CGFloat, multiplier: CGFloat)

public extension NSView {
    
    func layout(_ value: NSLayoutConstraint.Attribute) -> LayoutParts { (self, value, 0, 1) }
    
}
#else
public typealias LayoutParts = (view: UIView, attribute: NSLayoutConstraint.Attribute, constant: CGFloat, multiplier: CGFloat)

public extension UIView {
    
    func layout(_ value: NSLayoutConstraint.Attribute) -> LayoutParts { (self, value, 0, 1) }
    
}
#endif

infix operator !
public func +(lhs: LayoutParts, rhs: CGFloat) -> LayoutParts { (lhs.view, lhs.attribute, rhs, lhs.multiplier) }
public func -(lhs: LayoutParts, rhs: CGFloat) -> LayoutParts { (lhs.view, lhs.attribute, -rhs, lhs.multiplier) }
public func *(lhs: CGFloat, rhs: LayoutParts) -> LayoutParts { (rhs.view, rhs.attribute, rhs.constant, lhs) }
#if os(macOS)
public func !(lhs: NSLayoutConstraint, rhs: NSLayoutConstraint.Priority) -> NSLayoutConstraint {
    let constraint = lhs
    constraint.priority = rhs
    return constraint
}
#else
public func !(lhs: NSLayoutConstraint, rhs: UILayoutPriority) -> NSLayoutConstraint {
    let constraint = lhs
    constraint.priority = rhs
    return constraint
}
#endif

//Layout Attributes
public func ==(lhs: LayoutParts, rhs: CGFloat) -> NSLayoutConstraint { createConstraint(lhs: lhs, rhs: rhs, relation: .equal) }
public func ==(lhs: LayoutParts, rhs: LayoutParts) -> NSLayoutConstraint { createConstraint(lhs: lhs, rhs: rhs, relation: .equal) }
public func >=(lhs: LayoutParts, rhs: CGFloat) -> NSLayoutConstraint { createConstraint(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual) }
public func >=(lhs: LayoutParts, rhs: LayoutParts) -> NSLayoutConstraint { createConstraint(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual) }
public func <=(lhs: LayoutParts, rhs: CGFloat) -> NSLayoutConstraint { createConstraint(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual) }
public func <=(lhs: LayoutParts, rhs: LayoutParts) -> NSLayoutConstraint { createConstraint(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual) }

internal func createConstraint(lhs: LayoutParts, rhs: LayoutParts, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
    .init(item: lhs.view, attribute: lhs.attribute, relatedBy: relation, toItem: rhs.view, attribute: rhs.attribute, multiplier: 1, constant: rhs.constant)
}

internal func createConstraint(lhs: LayoutParts, rhs: CGFloat, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
    if [NSLayoutConstraint.Attribute.width, .height].contains(lhs.attribute) {
        return .init(item: lhs.view, attribute: lhs.attribute, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: rhs)
    }
    return .init(item: lhs.view, attribute: lhs.attribute, relatedBy: relation, toItem: lhs.view.superview, attribute: lhs.attribute, multiplier: 1, constant: rhs)
}

protocol ConstraintsGroup {
    
    var constraints: [NSLayoutConstraint] { get }
    
}

extension NSLayoutConstraint: ConstraintsGroup {
    
    var constraints: [NSLayoutConstraint] { [self] }
    
}

extension Array: ConstraintsGroup where Element == NSLayoutConstraint {
    
    var constraints: [NSLayoutConstraint] { self }
    
}

@resultBuilder
public struct LayoutBuilder {
    
    static func buildBlock(_ components: ConstraintsGroup...) -> [NSLayoutConstraint] { components.flatMap { $0.constraints } }
    static func buildOptional(_ component: [NSLayoutConstraint]?) -> [NSLayoutConstraint] { component.flatMap { $0.constraints } ?? [] }
    static func buildEither(first component: [NSLayoutConstraint]) -> [NSLayoutConstraint] { component.flatMap { $0.constraints } }
    static func buildEither(second component: [NSLayoutConstraint]) -> [NSLayoutConstraint] { component.flatMap { $0.constraints } }
    
}

public struct Layout {
    
    @discardableResult
    public init(@LayoutBuilder _ build: () -> [NSLayoutConstraint]) {
        let constraints = build()
        constraints.forEach {
            #if os(macOS)
            ($0.firstItem as? NSView)?.translatesAutoresizingMaskIntoConstraints = false
            #else
            ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
            #endif
        }
        NSLayoutConstraint.activate(constraints)
    }
    
}

