//
//  LayoutBuilderTests.swift
//  LayoutBuilderTests
//
//  Created by Ihor Malovanyi on 08.05.2021.
//

import XCTest
@testable import LayoutBuilder

class LayoutBuilderTests: XCTestCase {
    
    func testLayoutItemCreation() throws {
        let view = View()
        let layoutItem = view.layout(.top)

        XCTAssert(layoutItem.view == view && layoutItem.attribute == .top)
    }
    
    func testLayoutCGFloat() throws {
        let intValue = 1
        let doubleValue = 9
        let cgFloatValue = 10
        
        XCTAssert(intValue.cgFloatValue + doubleValue.cgFloatValue == cgFloatValue.cgFloatValue)
    }
    
    //MARK: Layout Builder Test
    
    func testLayoutBuilder() throws {
        let superview = View()
        let view_1 = View()
        let view_2: View? = View()
        let view_3: View? = nil
        
        superview.addSubview(view_1)
        superview.addSubview(view_2!)
        
        let testBool = true
        let testRelation: NSLayoutConstraint.Relation = .equal
        
        Layout {
            view_1.layout(.top) == superview
            if testBool {
                view_1.layout(.leading) == superview
            }
            if testRelation == .equal {
                view_1.layout(.bottom) == 10
            } else if testRelation == .greaterThanOrEqual {} else {}
            if let view_2 = view_2 {
                view_2.layout(.width) == view_1
            }
            if let _ = view_3 {} else {
                view_1.layout(.centerX) == 0
            }
        }
    }
    
    //MARK: Layout Relation Item creation test
    
    func testLayoutCreationItem() throws {
        let result = LBLayoutRelationItem(view: nil)
        XCTAssert(result.attribute == .notAnAttribute &&
                    result.constant.cgFloatValue == 0.0 &&
                    result.multiplier.cgFloatValue == 1 &&
                    result.priority == .required)
    }
    
    //MARK: Constraint creation test
    
    func testLayoutItemInternalConstraintCreationMethods() throws {
        let views = setupViewsForConstraintCreation()
        testConstraint(views.view.layout(.top).equal(to: .init(view: views.superview, attribute: .bottom, constant: 0, multiplier: 1, priority: .required)), forComplianceWith: .init(firstItem: views.view, firstAttribute: .top, secondItem: views.view.superview, secondAttribure: .bottom, relation: .equal, constant: 0, multiplier: 1, priority: .required))
        testConstraint(views.view.layout(.bottom).greaterThanOrEqual(to: .init(view: views.superview, attribute: .bottom, constant: 0, multiplier: 1, priority: .required)), forComplianceWith: .init(firstItem: views.view, firstAttribute: .bottom, secondItem: views.view.superview, secondAttribure: .bottom, relation: .greaterThanOrEqual, constant: 0, multiplier: 1, priority: .required))
        testConstraint(views.view.layout(.width).lessThanOrEqual(to: .init(view: nil, attribute: .notAnAttribute, constant: 10, multiplier: 1, priority: .required)), forComplianceWith: .init(firstItem: views.view, firstAttribute: .width, secondItem: nil, secondAttribure: .notAnAttribute, relation: .lessThanOrEqual, constant: 10, multiplier: 1, priority: .required))
    }
    
    func testConstraintCreation_Superview_Constant() throws {
        let views = setupViewsForConstraintCreation()
        var constraint = views.view.layout(.top) == 10
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .top,
                              secondItem: views.superview,
                              secondAttribure: .top,
                              relation: .equal,
                              constant: 10,
                              multiplier: 1,
                              priority: .required))
        
        constraint = views.view.layout(.left) >= views.superview + 10
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .left,
                              secondItem: views.superview,
                              secondAttribure: .left,
                              relation: .greaterThanOrEqual,
                              constant: 10,
                              multiplier: 1,
                              priority: .required))
        
        constraint = views.view.layout(.right) <= views.superview.layout(.left) + 10
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .right,
                              secondItem: views.superview,
                              secondAttribure: .left,
                              relation: .lessThanOrEqual,
                              constant: 10,
                              multiplier: 1,
                              priority: .required))
        
        constraint = views.view.layout(.centerY) == -10
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .centerY,
                              secondItem: views.superview,
                              secondAttribure: .centerY,
                              relation: .equal,
                              constant: -10,
                              multiplier: 1,
                              priority: .required))
    }

    func testConstraintCreation_Superview_Multiplier() throws {
        let views = setupViewsForConstraintCreation()
        var constraint = views.view.layout(.bottom) == 0.5 * views.superview
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .bottom,
                              secondItem: views.superview,
                              secondAttribure: .bottom,
                              relation: .equal,
                              constant: 0,
                              multiplier: 0.5,
                              priority: .required))
        
        constraint = views.view.layout(.width) >= 0.5 * views.superview.layout(.height)
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .width,
                              secondItem: views.superview,
                              secondAttribure: .height,
                              relation: .greaterThanOrEqual,
                              constant: 0,
                              multiplier: 0.5,
                              priority: .required))
    }
    
    func testConstraintCreation_Superview_Multiplier_Constant() throws {
        let views = setupViewsForConstraintCreation()
        var constraint = views.view.layout(.centerX) == 0.5 * views.superview - 10
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .centerX,
                              secondItem: views.superview,
                              secondAttribure: .centerX,
                              relation: .equal,
                              constant: -10,
                              multiplier: 0.5,
                              priority: .required))
        
        constraint = views.view.layout(.leading) <= 0.5 * views.superview.layout(.trailing) + 10
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .leading,
                              secondItem: views.superview,
                              secondAttribure: .trailing,
                              relation: .lessThanOrEqual,
                              constant: 10,
                              multiplier: 0.5,
                              priority: .required))
    }
    
    func testConstraintCreation_Superview_Constant_Priority() throws {
        let views = setupViewsForConstraintCreation()
        var constraint = views.view.layout(.firstBaseline) == 10 ! .defaultLow
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .firstBaseline,
                              secondItem: views.superview,
                              secondAttribure: .firstBaseline,
                              relation: .equal,
                              constant: 10,
                              multiplier: 1,
                              priority: .defaultLow))
        
        constraint = views.view.layout(.lastBaseline) >= views.superview + 10 ! .defaultHigh
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .lastBaseline,
                              secondItem: views.superview,
                              secondAttribure: .lastBaseline,
                              relation: .greaterThanOrEqual,
                              constant: 10,
                              multiplier: 1,
                              priority: .defaultHigh))
        
        constraint = views.view.layout(.bottomMargin) <= views.superview.layout(.centerYWithinMargins) + 10 ! .fittingSizeLevel
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .bottomMargin,
                              secondItem: views.superview,
                              secondAttribure: .centerYWithinMargins,
                              relation: .lessThanOrEqual,
                              constant: 10,
                              multiplier: 1,
                              priority: .fittingSizeLevel))
    }
    
    func testConstraintCreation_Superview_Multiplier_Priority() throws {
        let views = setupViewsForConstraintCreation()
        var constraint = views.view.layout(.topMargin) == 0.5 * views.superview ! .dragThatCanResizeScene
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .topMargin,
                              secondItem: views.superview,
                              secondAttribure: .topMargin,
                              relation: .equal,
                              constant: 0,
                              multiplier: 0.5,
                              priority: .dragThatCanResizeScene))
        
        constraint = views.view.layout(.bottomMargin) >= 0.5 * views.superview.layout(.centerY) ! .dragThatCannotResizeScene
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .bottomMargin,
                              secondItem: views.superview,
                              secondAttribure: .centerY,
                              relation: .greaterThanOrEqual,
                              constant: 0,
                              multiplier: 0.5,
                              priority: .dragThatCannotResizeScene))
    }
    
    func testConstraintCreation_Superview_Multiplier_Constant_Priority() throws {
        let views = setupViewsForConstraintCreation()
        var constraint = views.view.layout(.trailingMargin) == 0.5 * views.superview - 10 ! .dragThatCanResizeScene
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .trailingMargin,
                              secondItem: views.superview,
                              secondAttribure: .trailingMargin,
                              relation: .equal,
                              constant: -10,
                              multiplier: 0.5,
                              priority: .dragThatCanResizeScene))
        
        constraint = views.view.layout(.trailingMargin) <= 0.5 * views.superview.layout(.trailing) + 10 ! .sceneSizeStayPut
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .trailingMargin,
                              secondItem: views.superview,
                              secondAttribure: .trailing,
                              relation: .lessThanOrEqual,
                              constant: 10,
                              multiplier: 0.5,
                              priority: .sceneSizeStayPut))
    }
    
    func testConstraintCreation_RestCases() throws {
        let views = setupViewsForConstraintCreation()
        var constraint = views.view.layout(.centerXWithinMargins) == views.superview
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .centerXWithinMargins,
                              secondItem: views.superview,
                              secondAttribure: .centerXWithinMargins,
                              relation: .equal,
                              constant: 0,
                              multiplier: 1,
                              priority: .required))
        
        constraint = views.view.layout(.leftMargin) == views.superview ! .defaultHigh
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .leftMargin,
                              secondItem: views.superview,
                              secondAttribure: .leftMargin,
                              relation: .equal,
                              constant: 0,
                              multiplier: 1,
                              priority: .defaultHigh))
        
        constraint = views.view.layout(.width) == 10
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .width,
                              secondItem: nil,
                              secondAttribure: .notAnAttribute,
                              relation: .equal,
                              constant: 10,
                              multiplier: 1,
                              priority: .required))
        
        constraint = views.view.layout(.height) == 10 ! .defaultLow
        
        testConstraint(constraint, forComplianceWith:
                        .init(firstItem: views.view,
                              firstAttribute: .height,
                              secondItem: nil,
                              secondAttribure: .notAnAttribute,
                              relation: .equal,
                              constant: 10,
                              multiplier: 1,
                              priority: .defaultLow))
    }
    
    func testConstraint(_ constraint: NSLayoutConstraint, forComplianceWith parameters: ConstraintParameters) {
        XCTAssert(constraint.firstItem === parameters.firstItem)
        XCTAssert(constraint.firstAttribute == parameters.firstAttribute)
        XCTAssert(constraint.secondItem === parameters.secondItem)
        XCTAssert(constraint.secondAttribute == parameters.secondAttribure)
        XCTAssert(constraint.constant == parameters.constant)
        XCTAssert(constraint.multiplier == parameters.multiplier)
        XCTAssert(constraint.relation == parameters.relation)
        XCTAssert(constraint.priority == parameters.priority)
    }
    
    func setupViewsForConstraintCreation() -> (view: View, superview: View) {
        let superview = View()
        let view = View()
        superview.addSubview(view)
        return (view, superview)
    }
    
    struct ConstraintParameters {
       
        var firstItem: AnyObject
        var firstAttribute: NSLayoutConstraint.Attribute
        var secondItem: AnyObject?
        var secondAttribure: NSLayoutConstraint.Attribute
        var relation: NSLayoutConstraint.Relation
        var constant: CGFloat = 0
        var multiplier: CGFloat = 1
        var priority: LayoutPriority = .required
        
    }
    
}
