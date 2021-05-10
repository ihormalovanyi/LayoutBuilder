//
//  LayoutItem.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 10.05.2021.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

public struct LayoutItem {
    
    var view: View
    var attribute: NSLayoutConstraint.Attribute
    
    func equal(to relationItem: LayoutRelationItem, inset: Bool = false) -> NSLayoutConstraint {
        makeConstraint(item: self, relationItem: relationItem, relation: .equal, inset: inset)
    }
    
    func greaterThanOrEqual(to relationItem: LayoutRelationItem, inset: Bool = false) -> NSLayoutConstraint {
        makeConstraint(item: self, relationItem: relationItem, relation: .greaterThanOrEqual, inset: inset)
    }
    
    func lessThanOrEqual(to relationItem: LayoutRelationItem, inset: Bool = false) -> NSLayoutConstraint {
        makeConstraint(item: self, relationItem: relationItem, relation: .lessThanOrEqual, inset: inset)
    }
    
    internal func makeConstraint(item: LayoutItem, relationItem: LayoutRelationItem, relation: NSLayoutConstraint.Relation, inset: Bool = false) -> NSLayoutConstraint {
        var relationView = relationItem.view
        var relationAttribute = relationItem.attribute == .notAnAttribute ? item.attribute : relationItem.attribute
        let isRevercedAttribute = [NSLayoutConstraint.Attribute.right, .bottom].contains(relationAttribute)
        
        if relationItem.view == nil &&
            relationItem.attribute == .notAnAttribute &&
            ![NSLayoutConstraint.Attribute.width, .height].contains(item.attribute) {
            relationView = item.view.superview
            relationAttribute = item.attribute
        }
        
        let result = NSLayoutConstraint(item: item.view,
                           attribute: item.attribute,
                           relatedBy: relation,
                           toItem: relationView,
                           attribute: relationAttribute,
                           multiplier: relationItem.multiplier.cgFloatValue,
                           constant: isRevercedAttribute && inset ? -relationItem.constant.cgFloatValue : relationItem.constant.cgFloatValue)
        result.priority = relationItem.priority
        
        return result
    }
    
}
