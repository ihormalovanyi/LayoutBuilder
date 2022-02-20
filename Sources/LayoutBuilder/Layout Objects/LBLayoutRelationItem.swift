//
//  LayoutRelationItem.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 10.05.2021.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

public struct LBLayoutRelationItem {
    
    var view: View?
    var attribute: NSLayoutConstraint.Attribute = .notAnAttribute
    var constant: CGFloat = 0
    var multiplier: CGFloat = 1
    var priority: LayoutPriority = .required
    
}
