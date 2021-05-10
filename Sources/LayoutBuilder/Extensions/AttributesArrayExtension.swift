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

public extension Array where Element == NSLayoutConstraint.Attribute {
    
    static var edges: [NSLayoutConstraint.Attribute] { horizontal + vertical }
    static var horizontal: [NSLayoutConstraint.Attribute] { [.left, .right] }
    static var vertical: [NSLayoutConstraint.Attribute] { [.top, .bottom] }
    static var size: [NSLayoutConstraint.Attribute] { [.width, .height] }
    static var center: [NSLayoutConstraint.Attribute] { [.centerX, .centerY] }
    
    static func custom(_ attributes: NSLayoutConstraint.Attribute...) -> [NSLayoutConstraint.Attribute] { attributes }
    
}
