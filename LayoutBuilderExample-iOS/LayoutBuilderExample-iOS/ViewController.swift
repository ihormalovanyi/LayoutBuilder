//
//  ViewController.swift
//  LayoutBuilderExample-iOS
//
//  Created by Ihor Malovanyi on 04.05.2021.
//

import UIKit
import LayoutBuilder

final class ViewController: UIViewController {

    private lazy var redView = UIView()
    private lazy var blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redView.backgroundColor = .red
        blueView.backgroundColor = .blue
        
        view.addSubview(redView)
        view.addSubview(blueView)
        
        applySecondLayout()
    }
    
    private func applyFirstLayout() {
        //Vertical Constraints
        let redTopToSuperviewTop = redView.layout(.top) == view.layout(.top) + 20
        let superviewBottomToRedBottom = view.layout(.bottom) == redView + 20
        let blueTopToSuperviewTop = blueView.layout(.top) == 20
        let blueBottomToSuperviewBottom = blueView.layout(.bottom) == view.layout(.bottom) - 20

        //Horizontal Constraints
        let redLeadingToSuperviewLeading = redView.layout(.leading) == 20
        let blueLeadingToRedTrailing = blueView.layout(.leading) == redView.layout(.trailing) + 8
        let blueTrailingToSuperviewTrailing = blueView.layout(.trailing) == -20
        let redWidthToBlueWidthWithMultiplier = (redView.layout(.width) ==  blueView) ! .defaultLow
        let redWidthLessThenOrEqual = (redView.layout(.width) <= UIScreen.main.bounds.width / 2) ! .defaultHigh
        
        //Applying
        Layout {
            redTopToSuperviewTop
            superviewBottomToRedBottom
            blueTopToSuperviewTop
            blueBottomToSuperviewBottom
            redLeadingToSuperviewLeading
            blueLeadingToRedTrailing
            blueTrailingToSuperviewTrailing
            redWidthToBlueWidthWithMultiplier
            redWidthLessThenOrEqual
        }
    }
    
    private func applySecondLayout() {
        Layout {
            let equalWidths = Bool.random()
            
            //Horizontal Constraints
            redView.layout(.leading) == 20
            redView.layout(.trailing) == blueView.layout(.leading) - 8
            blueView.layout(.trailing) == -20
            if equalWidths {
                blueView.layout(.width) == redView
            } else {
                blueView.layout(.width) == ([0.3, 0.5, 0.9, 1].randomElement() ?? 1) * redView.layout(.width)
            }
            
            //Vertical Constraints
            redView.layout(.top) == blueView
            redView.layout(.centerY) == 0
            blueView.layout(.top) == 20
            blueView.layout(.centerY) == redView - 20
        }
    }


}

