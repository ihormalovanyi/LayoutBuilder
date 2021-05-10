//
//  LayoutCGFloat.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 10.05.2021.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

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
