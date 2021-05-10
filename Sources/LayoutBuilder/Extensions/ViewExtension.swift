//
//  ViewExtension.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 10.05.2021.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

public extension View {
    
    func layout(_ value: NSLayoutConstraint.Attribute) -> LayoutItem {
        LayoutItem(view: self, attribute: value)
    }
    
    func layout(_ value: [NSLayoutConstraint.Attribute]) -> [LayoutItem] {
        value.compactMap { LayoutItem(view: self, attribute: $0) }
    }
    
}
