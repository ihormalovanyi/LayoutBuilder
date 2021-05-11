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

public protocol LBLayoutRelationToGroupItemConvertable {
    
    var layoutRelationItem: LBLayoutRelationItem { get }
    
}

public protocol LBLayoutRelationItemConvertable {
    
    var layoutRelationItem: LBLayoutRelationItem { get }
    
}

extension LBLayoutItem: LBLayoutRelationItemConvertable {
    
    public var layoutRelationItem: LBLayoutRelationItem {
        .init(view: view, attribute: attribute, constant: 0, multiplier: 1, priority: .required)
    }
    
}

extension LBLayoutRelationItem: LBLayoutRelationItemConvertable, LBLayoutRelationToGroupItemConvertable {
    
    public var layoutRelationItem: LBLayoutRelationItem { self }
    
}

extension View: LBLayoutRelationItemConvertable, LBLayoutRelationToGroupItemConvertable {
    
    public var layoutRelationItem: LBLayoutRelationItem {
        .init(view: self, attribute: .notAnAttribute, constant: 0, multiplier: 1, priority: .required)
    }
    
}
