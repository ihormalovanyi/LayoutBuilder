//
//  AttributesArrayExtension.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 10.05.2021.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

extension NSLayoutConstraint.Attribute {
    
    static let notAnAtributeCases: [NSLayoutConstraint.Attribute] = [.height, .width]
    static let negativeValuedCases: [NSLayoutConstraint.Attribute] = [.right, .bottom, .trailing]
    
}
