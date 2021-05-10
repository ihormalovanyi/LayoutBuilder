//
//  Equality.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 10.05.2021.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

public func ==(lhs: LayoutItem, rhs: LayoutRelationItemConvertable) -> NSLayoutConstraint {
    lhs.equal(to: rhs.layoutRelationItem)
}
public func ==(lhs: [LayoutItem], rhs: LayoutRelationItemConvertable & LayoutRelationToGroupItemConvertable) -> [NSLayoutConstraint] {
    lhs.compactMap { $0.equal(to: rhs.layoutRelationItem, inset: true) }
}

public func >=(lhs: LayoutItem, rhs: LayoutRelationItemConvertable) -> NSLayoutConstraint {
    lhs.greaterThanOrEqual(to: rhs.layoutRelationItem)
}
public func >=(lhs: [LayoutItem], rhs: LayoutRelationItemConvertable & LayoutRelationToGroupItemConvertable) -> [NSLayoutConstraint] {
    lhs.compactMap { $0.greaterThanOrEqual(to: rhs.layoutRelationItem, inset: true) }
}

public func <=(lhs: LayoutItem, rhs: LayoutRelationItemConvertable) -> NSLayoutConstraint {
    lhs.lessThanOrEqual(to: rhs.layoutRelationItem)
}
public func <=(lhs: [LayoutItem], rhs: LayoutRelationItemConvertable & LayoutRelationToGroupItemConvertable) -> [NSLayoutConstraint] {
    lhs.compactMap { $0.lessThanOrEqual(to: rhs.layoutRelationItem, inset: true) }
}
