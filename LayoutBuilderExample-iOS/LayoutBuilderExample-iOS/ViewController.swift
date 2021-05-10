//
//  ViewController.swift
//  LayoutBuilderExample-iOS
//
//  Created by Ihor Malovanyi on 04.05.2021.
//

import UIKit
import LayoutBuilder

class ViewController: UIViewController {

    lazy var blackView = UIView()
    lazy var grayView = UIView()
    lazy var lightGrayView = UIView()
    lazy var label = UILabel()
    lazy var nextButton = UIButton()
    
    var colorViewsLayout: Layout!
    var buttonLayout: Layout!
    
    var isBlacSquare = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.alpha = 0
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        nextButton.setTitleColor(.systemPink, for: .normal)
        
        label.font = .systemFont(ofSize: 14)
        
        grayView.backgroundColor = .gray
        blackView.backgroundColor = .black
        lightGrayView.backgroundColor = .lightGray
        
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
        blackView.alpha = 0
        label.alpha = 0
        
        view.addSubview(blackView)
        view.addSubview(grayView)
        view.addSubview(lightGrayView)
        view.addSubview(label)
        view.addSubview(nextButton)
        
        layoutLabel()
        setupButtonFirstPosition()
        applyBlackSquare()
    }
    
    private func layoutLabel() {
        //Setup label constraints with no-instance Layout
        Layout {
            label.layout(.top) == blackView.layout(.bottom) + 15
            label.layout(.left) == blackView
        }
    }
    
    private func setupButtonFirstPosition() {
        //Create Layout instance for the button with start position constraints
        buttonLayout = Layout {
            nextButton.layout(.top) == view.layout(.bottom)
            nextButton.layout(.centerX) == 0
        }
    }
    
    private func applyBlackSquare() {
        label.text = "Kazimir Malevich, Black Square, 1915"
        
        //Initialize Layout with start constraints of black square
        colorViewsLayout = Layout {
            blackView.layout(.centerX) == 0
            blackView.layout(.centerY) == -100
            blackView.layout(.size) == 0.7 * view.layout(.width)
        }
        
        UIView.animate(withDuration: 1) {
            self.blackView.alpha = 1
            self.label.alpha = 1
        } completion: { _ in
            self.showButton()
        }
    }
    
    private func showButton() {
        //Rebuild button Layout for new position constraints
        buttonLayout.rebuild {
            nextButton.layout(.lastBaseline) == -50
            nextButton.layout(.centerX) == 0
        }
        
        UIView.animate(withDuration: 1) {
            self.nextButton.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    func rebuildLayout() {
        //Rebuild color views Layout based on isBlacSquare value
        colorViewsLayout.rebuild {
            blackView.layout(.centerX) == 0
            blackView.layout(.centerY) == -100 ! .defaultLow
            blackView.layout(.size) == 0.7 * view.layout(.width) ! .defaultLow
            
            if isBlacSquare {
                grayView.layout(.top) == blackView
                grayView.layout(.centerX) == blackView
                lightGrayView.layout(.top) == 0
                lightGrayView.layout(.centerX) == 0
            } else {
                grayView.layout(.center) == blackView
                grayView.layout(.size) == 0.7 * blackView
                
                for attribute in [NSLayoutConstraint.Attribute.centerX, .top] {
                    lightGrayView.layout(attribute) == grayView
                }
                
                lightGrayView.layout(.width) == 0.25 * grayView.layout(.height) + 20
                lightGrayView.layout(.centerY) == blackView
                
                blackView.layout(.top) == 0
                blackView.layout(.size) == view
            }
        }
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func nextAction() {
        isBlacSquare.toggle()
        nextButton.setTitle(isBlacSquare ? "Next" : "Previous", for: .normal)
        rebuildLayout()
    }
    
}
