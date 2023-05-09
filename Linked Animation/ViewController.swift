//
//  ViewController.swift
//  Linked Animation
//
//  Created by Sergei Semko on 5/7/23.
//

import UIKit

class ViewController: UIViewController {
    
    let movingView = UIView()
    let sliderControl = UISlider()
    
    let animator = UIViewPropertyAnimator(duration: 0.7, curve: .easeOut)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        movingView.backgroundColor = .systemBlue
        movingView.layer.cornerCurve = .continuous
        movingView.layer.cornerRadius = 8
        view.addSubview(movingView)
        
        view.addSubview(sliderControl)
        
        sliderControl.addAction(.init(handler: {_ in
            self.animator.fractionComplete = CGFloat(self.sliderControl.value)
        }), for: .valueChanged)
        
        sliderControl.addAction(.init(handler: {_ in
            self.animator.startAnimation()
            self.sliderControl.setValue(1, animated: true)
        }), for: [.touchUpInside, .touchUpOutside])
        
        animator.pausesOnCompletion = true
        
        animator.addAnimations {
            self.movingView.frame.origin.x = self.view.frame.width - self.view.layoutMargins.right - self.view.layoutMargins.right - self.movingView.frame.width
            self.movingView.transform = .identity.scaledBy(x: 1.5, y: 1.5).rotated(by: .pi / 2)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if movingView.transform == .identity {
            movingView.frame = .init(x: view.layoutMargins.left, y: 110, width: 80, height: 80)
            
            sliderControl.sizeToFit()
            sliderControl.frame = .init(
                x: view.layoutMargins.left,
                y: movingView.frame.maxY + 44,
                width: view.frame.width - view.layoutMargins.left - view.layoutMargins.right,
                height: sliderControl.frame.height
            )
        }
        
        
    }
    
}
