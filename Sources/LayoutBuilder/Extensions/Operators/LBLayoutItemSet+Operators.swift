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

public extension LBLayoutItemSet {
    
    static func ==(lhs: LBLayoutItemSet, rhs: Any) -> [NSLayoutConstraint] {
        lhs.attributes.compactMap {
            let insetAttributes = lhs.parameters.contains(.inset) && NSLayoutConstraint.Attribute.negativeValuedCases.contains($0)
 
            if let cgFloat = rhs as? CGFloat {
                return .init(item: lhs.view, attribute: $0, relatedBy: .equal, toItem: lhs.view.superview, attribute: $0, multiplier: 1, constant: cgFloat * (insetAttributes ? -1 : 1))
            } else if let view = rhs as? View {
                return .init(item: lhs.view, attribute: $0, relatedBy: .equal, toItem: view, attribute: $0, multiplier: 1, constant: 0)
            } else if let item = rhs as? LBLayoutRelationItem {
                return .init(item: lhs.view, attribute: $0, relatedBy: .equal, toItem: item.view, attribute: $0, multiplier: item.multiplier, constant: item.constant * (insetAttributes ? -1 : 1))
            }
            
            return nil
        }
    }
    
    static func >=(lhs: LBLayoutItemSet, rhs: Any) -> [NSLayoutConstraint] {
        lhs.attributes.compactMap {
            if let cgFloat = rhs as? CGFloat {
                return .init(item: lhs.view, attribute: $0, relatedBy: .greaterThanOrEqual, toItem: lhs.view.superview, attribute: $0, multiplier: 1, constant: cgFloat)
            } else if let view = rhs as? View {
                return .init(item: lhs.view, attribute: $0, relatedBy: .greaterThanOrEqual, toItem: view, attribute: $0, multiplier: 1, constant: 0)
            } else if let item = rhs as? LBLayoutRelationItem {
                return .init(item: lhs.view, attribute: $0, relatedBy: .greaterThanOrEqual, toItem: item.view, attribute: $0, multiplier: item.multiplier, constant: item.constant)
            }
            
            return nil
        }
    }
    
    static func <=(lhs: LBLayoutItemSet, rhs: Any) -> [NSLayoutConstraint] {
        lhs.attributes.compactMap {
            if let cgFloat = rhs as? CGFloat {
                return .init(item: lhs.view, attribute: $0, relatedBy: .lessThanOrEqual, toItem: lhs.view.superview, attribute: $0, multiplier: 1, constant: cgFloat)
            } else if let view = rhs as? View {
                return .init(item: lhs.view, attribute: $0, relatedBy: .lessThanOrEqual, toItem: view, attribute: $0, multiplier: 1, constant: 0)
            } else if let item = rhs as? LBLayoutRelationItem {
                return .init(item: lhs.view, attribute: $0, relatedBy: .lessThanOrEqual, toItem: item.view, attribute: $0, multiplier: item.multiplier, constant: item.constant)
            }
            
            return nil
        }
    }
    
}
