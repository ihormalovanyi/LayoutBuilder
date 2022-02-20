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

infix operator ! : LogicalConjunctionPrecedence

public extension NSLayoutConstraint {
    
    static func !(lhs: NSLayoutConstraint, rhs: LayoutPriority) -> NSLayoutConstraint {
        lhs.priority = rhs
        return lhs
    }
    
}

