//
//  LayoutBuilder.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 04.05.2021.
//

@_exported import LayoutBuilder

#if canImport(UIKit)
    import UIKit
    public typealias View = UIView
    public typealias LayoutPriority = UILayoutPriority
#elseif canImport(AppKit)
    import AppKit
    public typealias View = NSView
    public typealias LayoutPriority = NSLayoutConstraint.Priority
#endif

//https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ProgrammaticallyCreatingConstraints.html#//apple_ref/doc/uid/TP40010853-CH16-SW1
//Example: item1.attribute = multiplier * item2.attrubute + constant

//MARK: Operators

infix operator ! : AdditionPrecedence
public func +(lhs: LayoutParts, rhs: CGFloat) -> LayoutParts { (lhs.view, lhs.attribute, rhs, lhs.multiplier) }
public func -(lhs: LayoutParts, rhs: CGFloat) -> LayoutParts { (lhs.view, lhs.attribute, -rhs, lhs.multiplier) }
public func *(lhs: CGFloat, rhs: LayoutParts) -> LayoutParts { (rhs.view, rhs.attribute, rhs.constant, lhs) }
public func !(lhs: NSLayoutConstraint, rhs: LayoutPriority) -> NSLayoutConstraint {
    let constraint = lhs
    constraint.priority = rhs
    return constraint
}

public func ==(lhs: LayoutParts, rhs: CGFloat) -> NSLayoutConstraint { createConstraint(lhs: lhs, rhs: rhs, relation: .equal) }
public func ==(lhs: LayoutParts, rhs: LayoutParts) -> NSLayoutConstraint { createConstraint(lhs: lhs, rhs: rhs, relation: .equal) }
public func >=(lhs: LayoutParts, rhs: CGFloat) -> NSLayoutConstraint { createConstraint(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual) }
public func >=(lhs: LayoutParts, rhs: LayoutParts) -> NSLayoutConstraint { createConstraint(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual) }
public func <=(lhs: LayoutParts, rhs: CGFloat) -> NSLayoutConstraint { createConstraint(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual) }
public func <=(lhs: LayoutParts, rhs: LayoutParts) -> NSLayoutConstraint { createConstraint(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual) }

//MARK: Support logic

public typealias LayoutParts = (view: View, attribute: NSLayoutConstraint.Attribute, constant: CGFloat, multiplier: CGFloat)

public extension View {
    
    func layout(_ value: NSLayoutConstraint.Attribute) -> LayoutParts { (self, value, 0, 1) }
    
}

internal func createConstraint(lhs: LayoutParts, rhs: LayoutParts, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
    .init(item: lhs.view, attribute: lhs.attribute, relatedBy: relation, toItem: rhs.view, attribute: rhs.attribute, multiplier: 1, constant: rhs.constant)
}

internal func createConstraint(lhs: LayoutParts, rhs: CGFloat, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
    if [NSLayoutConstraint.Attribute.width, .height].contains(lhs.attribute) {
        return .init(item: lhs.view, attribute: lhs.attribute, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: rhs)
    }
    return .init(item: lhs.view, attribute: lhs.attribute, relatedBy: relation, toItem: lhs.view.superview, attribute: lhs.attribute, multiplier: 1, constant: rhs)
}

public protocol ConstraintsGroup {

    var constraints: [NSLayoutConstraint] { get }

}

extension NSLayoutConstraint: ConstraintsGroup {

    public var constraints: [NSLayoutConstraint] { [self] }

}

extension Array: ConstraintsGroup where Element == NSLayoutConstraint {

    public var constraints: [NSLayoutConstraint] { self }

}

//MARK: Layout Result Builder

@resultBuilder
public enum LayoutResultBuilder {
    
    public static func buildBlock(_ components: ConstraintsGroup...) -> [NSLayoutConstraint] { components.flatMap(\.constraints) }
    public  static func buildOptional(_ components: [ConstraintsGroup]?) -> [NSLayoutConstraint] { components?.flatMap(\.constraints) ?? [] }
    public static func buildEither(first components: [ConstraintsGroup]) -> [NSLayoutConstraint] { components.flatMap(\.constraints) }
    public static func buildEither(second components: [ConstraintsGroup]) -> [NSLayoutConstraint] { components.flatMap(\.constraints) }
    
}

public struct Layout {
    
    @discardableResult
    public init(@LayoutResultBuilder _ build: () -> [NSLayoutConstraint]) {
        let constraints = build()
        constraints.forEach {
            ($0.firstItem as? View)?.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate(constraints)
    }
    
}

