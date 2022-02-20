//
//  File.swift
//  
//
//  Created by Ihor Malovanyi on 20.02.2022.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

public extension LBLayoutRelationItem {
    
    static func +(lhs: LBLayoutRelationItem, rhs: CGFloat) -> LBLayoutRelationItem {
        .init(view: lhs.view, attribute: lhs.attribute, constant: lhs.constant + rhs, multiplier: lhs.multiplier, priority: lhs.priority)
    }
    
    static func -(lhs: LBLayoutRelationItem, rhs: CGFloat) -> LBLayoutRelationItem {
        .init(view: lhs.view, attribute: lhs.attribute, constant: lhs.constant - rhs, multiplier: lhs.multiplier, priority: lhs.priority)
    }
    
    static func *(lhs: CGFloat, rhs: LBLayoutRelationItem) -> LBLayoutRelationItem {
        .init(view: rhs.view, attribute: rhs.attribute, constant: rhs.constant, multiplier: rhs.multiplier * lhs, priority: rhs.priority)
    }
    
    static func /(lhs: CGFloat, rhs: LBLayoutRelationItem) -> LBLayoutRelationItem {
        .init(view: rhs.view, attribute: rhs.attribute, constant: rhs.constant, multiplier: rhs.multiplier / lhs, priority: rhs.priority)
    }
    
}

public extension LBLayoutRelationItem {
    
    static func ==(lhs: LBLayoutItem, rhs: LBLayoutRelationItem) -> NSLayoutConstraint {
        .init(item: lhs.view, attribute: lhs.attribute, relatedBy: .equal, toItem: rhs.view, attribute: rhs.attribute ?? lhs.attribute, multiplier: rhs.multiplier, constant: rhs.constant)
    }
    
    static func >=(lhs: LBLayoutItem, rhs: LBLayoutRelationItem) -> NSLayoutConstraint {
        .init(item: lhs.view, attribute: lhs.attribute, relatedBy: .greaterThanOrEqual, toItem: rhs.view, attribute: rhs.attribute ?? lhs.attribute, multiplier: rhs.multiplier, constant: rhs.constant)
    }
    
    static func <=(lhs: LBLayoutItem, rhs: LBLayoutRelationItem) -> NSLayoutConstraint {
        .init(item: lhs.view, attribute: lhs.attribute, relatedBy: .lessThanOrEqual, toItem: rhs.view, attribute: rhs.attribute ?? lhs.attribute, multiplier: rhs.multiplier, constant: rhs.constant)
    }
    
}
