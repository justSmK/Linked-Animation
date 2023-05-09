//
//  ViewController.swift
//  Linked Animation
//
//  Created by Sergei Semko on 5/7/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let sideOfSquare: CGFloat = 128
    private let scale: CGFloat = 1.5
    private let propertyAnimator = UIViewPropertyAnimator(duration: 0.4, curve: .easeInOut)
    
    private lazy var squareView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .link
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var sliderView: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderReleased), for: .touchUpInside)
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setConstraints()
        launchAnimation()
    }
    
    private func launchAnimation() {
        propertyAnimator.pausesOnCompletion = true
        propertyAnimator.addAnimations { [weak self] in
            guard let self else { return }
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            self.squareView.transform = CGAffineTransform(rotationAngle: .pi / 2).concatenating(transform)
//            let bounds = self.squareView.frame.applying(transform)
//            squareView.center.x = view.bounds.width - bounds.midX
            let finalPosition = view.frame.width - ((squareView.center.x * 1.5) - view.layoutMargins.right / 2)
            squareView.center.x = finalPosition
        }
    }

    @objc private func sliderValueChanged() {
        propertyAnimator.fractionComplete = CGFloat(sliderView.value)
    }
    
    @objc private func sliderReleased() {
        sliderView.setValue(1.0, animated: true)
        propertyAnimator.startAnimation()
    }
}


extension ViewController {
    private func setConstraints() {
        
        view.addSubview(squareView)
        let squareViewConstraints: [NSLayoutConstraint] = [
            squareView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            squareView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 60),
            squareView.heightAnchor.constraint(equalToConstant: sideOfSquare),
            squareView.widthAnchor.constraint(equalToConstant: sideOfSquare)
        ]
        NSLayoutConstraint.activate(squareViewConstraints)
        
        view.addSubview(sliderView)
        let sliderConstraints: [NSLayoutConstraint] = [
            sliderView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            sliderView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            sliderView.topAnchor.constraint(equalTo: squareView.layoutMarginsGuide.bottomAnchor, constant: 60)
        ]
        NSLayoutConstraint.activate(sliderConstraints)
    }
}
