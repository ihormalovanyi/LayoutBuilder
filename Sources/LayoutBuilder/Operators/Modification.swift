//
//  Modification.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 10.05.2021.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

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
