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

public extension LBLayoutItem {
    
    static func +(lhs: LBLayoutItem, rhs: CGFloat) -> LBLayoutRelationItem {
        .init(view: lhs.view, attribute: lhs.attribute, constant: rhs)
    }
    
    static func *(lhs: CGFloat, rhs: LBLayoutItem) -> LBLayoutRelationItem {
        .init(view: rhs.view, attribute: rhs.attribute, multiplier: lhs)
    }
    
}

public extension LBLayoutItem {
    
    static func ==(lhs: LBLayoutItem, rhs: LBLayoutItem) -> NSLayoutConstraint {
        .init(item: lhs.view, attribute: lhs.attribute, relatedBy: .equal, toItem: rhs.view, attribute: rhs.attribute, multiplier: 1, constant: 0)
    }
    
    static func >=(lhs: LBLayoutItem, rhs: LBLayoutItem) -> NSLayoutConstraint {
        .init(item: lhs.view, attribute: lhs.attribute, relatedBy: .greaterThanOrEqual, toItem: rhs.view, attribute: rhs.attribute, multiplier: 1, constant: 0)
    }
    
    static func <=(lhs: LBLayoutItem, rhs: LBLayoutItem) -> NSLayoutConstraint {
        .init(item: lhs.view, attribute: lhs.attribute, relatedBy: .lessThanOrEqual, toItem: rhs.view, attribute: rhs.attribute, multiplier: 1, constant: 0)
    }
    
}


