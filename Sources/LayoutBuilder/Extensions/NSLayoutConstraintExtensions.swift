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
