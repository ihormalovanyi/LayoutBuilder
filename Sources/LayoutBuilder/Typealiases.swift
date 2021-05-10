//
//  Typealiases.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 10.05.2021.
//

#if canImport(UIKit)
    import UIKit
    public typealias View = UIView
    public typealias LayoutPriority = UILayoutPriority
#elseif canImport(AppKit)
    import AppKit
    public typealias View = NSView
    public typealias LayoutPriority = NSLayoutConstraint.Priority
#endif
