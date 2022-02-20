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

//TODO: Future
private extension NSLayoutConstraint {
    
    enum AttributeSet {
        
        case horizontal
        case vertical
        case size
        case center
        case edges
        
        var attributes: [NSLayoutConstraint.Attribute] {
            switch self {
            case .horizontal: return [.left, .right]
            case .vertical: return [.top, .bottom]
            case .size: return [.height, .width]
            case .center: return [.centerX, .centerY]
            case .edges: return [.left, .right, .top, .bottom]
            }
        }
        
    }
    
}

public extension Array where Element == NSLayoutConstraint.Attribute {
    
    static let horizontal: [NSLayoutConstraint.Attribute] = [.left, .right]
    static let vertical: [NSLayoutConstraint.Attribute] = [.top, .bottom]
    static let size: [NSLayoutConstraint.Attribute] = [.height, .width]
    static let center: [NSLayoutConstraint.Attribute] = [.centerY, .centerX]
    static let edges: [NSLayoutConstraint.Attribute] = [.top, .bottom, .left, .right]
    
}
