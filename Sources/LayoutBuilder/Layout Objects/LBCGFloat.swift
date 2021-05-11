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

public protocol LBCGFloat {
    
    var cgFloatValue: CGFloat { get }
    
}

extension LBCGFloat {
    
    public var layoutRelationItem: LBLayoutRelationItem {
        .init(view: nil, attribute: .notAnAttribute, constant: cgFloatValue, multiplier: 1, priority: .required)
    }
    
}

extension CGFloat: LBCGFloat {
    
    public var cgFloatValue: CGFloat { self }
    
}

extension Double: LBCGFloat {
    
    public var cgFloatValue: CGFloat { CGFloat(self) }
    
}

extension Int: LBCGFloat {
    
    public var cgFloatValue: CGFloat { CGFloat(self) }
    
}
