//
//  LayoutBuilder.swift
//  LayoutBuilder
//
//  Created by Ihor Malovanyi on 04.05.2021.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

public class Layout {

    ///All constraints in the Layout instance
    private(set) var constraints: [NSLayoutConstraint] = []
    
    ///Layout active status. Shows built constraints are active or not
    private(set) var isActive = true {
        didSet {
            constraints.forEach { $0.isActive = isActive }
        }
    }
    
    @resultBuilder
    public struct LayoutResultBuilder {
        
        public static func buildBlock(_ components: ConstraintsGroup...) -> [NSLayoutConstraint] { components.flatMap(\.constraints) }
        public static func buildOptional(_ components: [ConstraintsGroup]?) -> [NSLayoutConstraint] { components?.flatMap(\.constraints) ?? [] }
        public static func buildEither(first components: [ConstraintsGroup]) -> [NSLayoutConstraint] { components.flatMap(\.constraints) }
        public static func buildEither(second components: [ConstraintsGroup]) -> [NSLayoutConstraint] { components.flatMap(\.constraints) }
        public static func buildArray(_ components: [[ConstraintsGroup]]) -> [NSLayoutConstraint] { components.reduce([], +).flatMap(\.constraints) }
        
    }
    
    @discardableResult
    public init(@LayoutResultBuilder _ build: () -> [NSLayoutConstraint]) {
        constraints = buildConstraints(build)
    }
    
    private func buildConstraints(@LayoutResultBuilder _ build: () -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        let constraints = build()
        constraints.forEach {
            ($0.firstItem as? View)?.translatesAutoresizingMaskIntoConstraints = false
        }
        if isActive {
            NSLayoutConstraint.activate(constraints)
        }
        
        return constraints
    }
    
    ///Deactivates all constraints previously built in the Layout instance and replaces them with new constraints build.
    public func rebuild(@LayoutResultBuilder _ build: () -> [NSLayoutConstraint]) {
        let oldActiveStatus = isActive
        deactivate()
        constraints.removeAll()
        if oldActiveStatus {
            activate()
        }
        constraints = buildConstraints(build)
    }
    
    ///Appends new constraints to exist in the Layout instance constraints. Activates them if `isActive` is true.
    public func append(@LayoutResultBuilder _ build: () -> [NSLayoutConstraint]) {
        constraints += buildConstraints(build)
    }
    
    ///Deactivates all constraints in the Layout instance
    public func deactivate() {
        isActive = false
    }
    
    ///Activates all constraints in the Layout instance
    public func activate() {
        isActive = true
    }
    
}
