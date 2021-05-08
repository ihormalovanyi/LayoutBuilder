//
//  LayoutBuilder.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 04.05.2021.
//

#if canImport(UIKit)
    import UIKit
    public typealias View = UIView
    public typealias LayoutPriority = UILayoutPriority
#elseif canImport(AppKit)
    import AppKit
    public typealias View = NSView
    public typealias LayoutPriority = NSLayoutConstraint.Priority
#endif

//MARK: View Layout extension

public extension View {
    
    func layout(_ value: NSLayoutConstraint.Attribute) -> LayoutItem {
        .init(view: self, attribute: value)
    }
    
}

//MARK: Constraint group protocol with extensions

public protocol ConstraintsGroup {

    var constraints: [NSLayoutConstraint] { get }

}

extension NSLayoutConstraint: ConstraintsGroup {

    public var constraints: [NSLayoutConstraint] { [self] }

}

extension Array: ConstraintsGroup where Element == NSLayoutConstraint {

    public var constraints: [NSLayoutConstraint] { self }

}

//MARK: Layout Builder

@resultBuilder
public struct LayoutResultBuilder {
    
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

//MARK: Layout objects

public struct LayoutRelationItem {
    
    var view: View?
    var attribute: NSLayoutConstraint.Attribute = .notAnAttribute
    var constant: LayoutCGFloat = 0
    var multiplier: LayoutCGFloat = 1
    var priority: LayoutPriority = .required
    
}

public struct LayoutItem {
    
    var view: View
    var attribute: NSLayoutConstraint.Attribute
    
    func equal(to relationItem: LayoutRelationItem) -> NSLayoutConstraint {
        makeConstraint(item: self, relationItem: relationItem, relation: .equal)
    }
    
    func greaterThanOrEqual(to relationItem: LayoutRelationItem) -> NSLayoutConstraint {
        makeConstraint(item: self, relationItem: relationItem, relation: .greaterThanOrEqual)
    }
    
    func lessThanOrEqual(to relationItem: LayoutRelationItem) -> NSLayoutConstraint {
        makeConstraint(item: self, relationItem: relationItem, relation: .lessThanOrEqual)
    }
    
    internal func makeConstraint(item: LayoutItem, relationItem: LayoutRelationItem, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        var relationView = relationItem.view
        var relationAttribute = relationItem.attribute == .notAnAttribute ? item.attribute : relationItem.attribute
        
        if relationItem.view == nil &&
            relationItem.attribute == .notAnAttribute &&
            ![NSLayoutConstraint.Attribute.width, .height].contains(item.attribute) {
            relationView = item.view.superview
            relationAttribute = item.attribute
        }
        
        let result = NSLayoutConstraint(item: item.view,
                           attribute: item.attribute,
                           relatedBy: relation,
                           toItem: relationView,
                           attribute: relationAttribute,
                           multiplier: relationItem.multiplier.cgFloatValue,
                           constant: relationItem.constant.cgFloatValue)
        result.priority = relationItem.priority
        
        return result
    }
    
}

//MARK: Layout Relation Item Convertable protocol with extensions

public protocol LayoutRelationItemConvertable {
    
    var layoutRelationItem: LayoutRelationItem { get }
    
}

extension LayoutItem: LayoutRelationItemConvertable {
    
    public var layoutRelationItem: LayoutRelationItem {
        .init(view: view, attribute: attribute, constant: 0, multiplier: 1, priority: .required)
    }
    
}

extension LayoutRelationItem: LayoutRelationItemConvertable {
    
    public var layoutRelationItem: LayoutRelationItem { self }
    
}

extension View: LayoutRelationItemConvertable {
    
    public var layoutRelationItem: LayoutRelationItem {
        .init(view: self, attribute: .notAnAttribute, constant: 0, multiplier: 1, priority: .required)
    }
    
}

public protocol LayoutCGFloat: LayoutRelationItemConvertable {
    
    var cgFloatValue: CGFloat { get }
    
}

//MARK: Layout CGFloat protocol with extensions

extension LayoutCGFloat {
    
    public var layoutRelationItem: LayoutRelationItem {
        .init(view: nil, attribute: .notAnAttribute, constant: cgFloatValue, multiplier: 1, priority: .required)
    }
    
}

extension CGFloat: LayoutCGFloat {
    
    public var cgFloatValue: CGFloat { self }
    
}

extension Double: LayoutCGFloat {
    
    public var cgFloatValue: CGFloat { CGFloat(self) }
    
}

extension Int: LayoutCGFloat {
    
    public var cgFloatValue: CGFloat { CGFloat(self) }
    
}

//MARK: Equaliti constructors

public func ==(lhs: LayoutItem, rhs: LayoutRelationItemConvertable) -> NSLayoutConstraint {
    lhs.equal(to: rhs.layoutRelationItem)
}

public func >=(lhs: LayoutItem, rhs: LayoutRelationItemConvertable) -> NSLayoutConstraint {
    lhs.greaterThanOrEqual(to: rhs.layoutRelationItem)
}

public func <=(lhs: LayoutItem, rhs: LayoutRelationItemConvertable) -> NSLayoutConstraint {
    lhs.lessThanOrEqual(to: rhs.layoutRelationItem)
}

//MARK: Upbuilding methods

infix operator ! : AdditionPrecedence
public func !(lhs: LayoutRelationItemConvertable, rhs: LayoutPriority) -> LayoutRelationItem {
    var lhs = lhs.layoutRelationItem
    lhs.priority = rhs
    
    return lhs
}

public func +(lhs: LayoutRelationItemConvertable, rhs: LayoutCGFloat) -> LayoutRelationItem {
    var lhs = lhs.layoutRelationItem
    lhs.constant = rhs
    
    return lhs
}

public func -(lhs: LayoutRelationItemConvertable, rhs: LayoutCGFloat) -> LayoutRelationItem { lhs + (-rhs.cgFloatValue) }

public func *(lhs: LayoutCGFloat , rhs: LayoutRelationItemConvertable) -> LayoutRelationItem {
    var rhs = rhs.layoutRelationItem
    rhs.multiplier = lhs
    
    return rhs
}
