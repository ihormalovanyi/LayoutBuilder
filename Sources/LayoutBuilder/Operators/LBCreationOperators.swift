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

public func ==(lhs: LBLayoutItem, rhs: LBLayoutRelationItemConvertable) -> NSLayoutConstraint {
    lhs.equal(to: rhs.layoutRelationItem)
}
public func ==(lhs: [LBLayoutItem], rhs: LBLayoutRelationItemConvertable & LBLayoutRelationToGroupItemConvertable) -> [NSLayoutConstraint] {
    lhs.compactMap { $0.equal(to: rhs.layoutRelationItem, inset: true) }
}
public func ==(lhs: LBLayoutItem, rhs: LBCGFloat) -> NSLayoutConstraint {
    lhs.equal(to: rhs.layoutRelationItem)
}
public func ==(lhs: [LBLayoutItem], rhs: LBCGFloat) -> [NSLayoutConstraint] {
    lhs.compactMap { $0 == rhs }
}

public func >=(lhs: LBLayoutItem, rhs: LBLayoutRelationItemConvertable) -> NSLayoutConstraint {
    lhs.greaterThanOrEqual(to: rhs.layoutRelationItem)
}
public func >=(lhs: [LBLayoutItem], rhs: LBLayoutRelationItemConvertable & LBLayoutRelationToGroupItemConvertable) -> [NSLayoutConstraint] {
    lhs.compactMap { $0.greaterThanOrEqual(to: rhs.layoutRelationItem, inset: true) }
}
public func >=(lhs: LBLayoutItem, rhs: LBCGFloat) -> NSLayoutConstraint {
    lhs.greaterThanOrEqual(to: rhs.layoutRelationItem)
}
public func >=(lhs: [LBLayoutItem], rhs: LBCGFloat) -> [NSLayoutConstraint] {
    lhs.compactMap { $0 >= rhs }
}

public func <=(lhs: LBLayoutItem, rhs: LBLayoutRelationItemConvertable) -> NSLayoutConstraint {
    lhs.lessThanOrEqual(to: rhs.layoutRelationItem)
}
public func <=(lhs: [LBLayoutItem], rhs: LBLayoutRelationItemConvertable & LBLayoutRelationToGroupItemConvertable) -> [NSLayoutConstraint] {
    lhs.compactMap { $0.lessThanOrEqual(to: rhs.layoutRelationItem, inset: true) }
}
public func <=(lhs: LBLayoutItem, rhs: LBCGFloat) -> NSLayoutConstraint {
    lhs.lessThanOrEqual(to: rhs.layoutRelationItem)
}
public func <=(lhs: [LBLayoutItem], rhs: LBCGFloat) -> [NSLayoutConstraint] {
    lhs.compactMap { $0 <= rhs }
}
