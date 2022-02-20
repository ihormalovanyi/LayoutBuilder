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

public extension CGFloat {
    
    static func ==(lhs: LBLayoutItem, rhs: CGFloat) -> NSLayoutConstraint {
        let item2: View? = NSLayoutConstraint.Attribute.notAnAtributeCases.contains(lhs.attribute) ? nil : lhs.view.superview
        return .init(item: lhs.view, attribute: lhs.attribute, relatedBy: .equal, toItem: item2, attribute: item2 == nil ? .notAnAttribute : lhs.attribute, multiplier: 1, constant: 0)
    }
    
    static func >=(lhs: LBLayoutItem, rhs: CGFloat) -> NSLayoutConstraint {
        let item2: View? = NSLayoutConstraint.Attribute.notAnAtributeCases.contains(lhs.attribute) ? nil : lhs.view.superview
        return .init(item: lhs.view, attribute: lhs.attribute, relatedBy: .greaterThanOrEqual, toItem: item2, attribute: item2 == nil ? .notAnAttribute : lhs.attribute, multiplier: 1, constant: 0)
    }
    
    static func <=(lhs: LBLayoutItem, rhs: CGFloat) -> NSLayoutConstraint {
        let item2: View? = NSLayoutConstraint.Attribute.notAnAtributeCases.contains(lhs.attribute) ? nil : lhs.view.superview
        return .init(item: lhs.view, attribute: lhs.attribute, relatedBy: .lessThanOrEqual, toItem: item2, attribute: item2 == nil ? .notAnAttribute : lhs.attribute, multiplier: 1, constant: 0)
    }
    
}
