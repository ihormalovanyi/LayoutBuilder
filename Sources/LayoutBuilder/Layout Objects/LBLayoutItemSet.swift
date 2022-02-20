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

public struct LBLayoutItemSet {
    
    var view: View
    var attributes: [NSLayoutConstraint.Attribute]
    var parameters: [View.Parameter] = []
    
}

