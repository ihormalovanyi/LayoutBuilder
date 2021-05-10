//
//  ConvertableProtocol.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 10.05.2021.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

public protocol LayoutRelationToGroupItemConvertable {
    
    var layoutRelationItem: LayoutRelationItem { get }
    
}

public protocol LayoutRelationItemConvertable {
    
    var layoutRelationItem: LayoutRelationItem { get }
    
}

extension LayoutItem: LayoutRelationItemConvertable {
    
    public var layoutRelationItem: LayoutRelationItem {
        .init(view: view, attribute: attribute, constant: 0, multiplier: 1, priority: .required)
    }
    
}

extension LayoutRelationItem: LayoutRelationItemConvertable, LayoutRelationToGroupItemConvertable {
    
    public var layoutRelationItem: LayoutRelationItem { self }
    
}

extension View: LayoutRelationItemConvertable, LayoutRelationToGroupItemConvertable {
    
    public var layoutRelationItem: LayoutRelationItem {
        .init(view: self, attribute: .notAnAttribute, constant: 0, multiplier: 1, priority: .required)
    }
    
}

public protocol LayoutCGFloat: LayoutRelationItemConvertable, LayoutRelationToGroupItemConvertable {
    
    var cgFloatValue: CGFloat { get }
    
}
