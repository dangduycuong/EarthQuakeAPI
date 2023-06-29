//
//  AnimationLoadingViewController.swift
//  ShimmerSwift
//
//  Created by cuongdd on 22/06/2023.
//

import UIKit
import Lottie

class AnimationLoadingViewController: BaseViewController {
    private lazy var animationView: LottieAnimationView = {
        let jsonName = "blue_loading"
        let animation = LottieAnimation.named(jsonName)
        let view = LottieAnimationView(animation: animation)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        animationView.play()
    }
    
    // MARK: - Navigation
    private func setupUI() {
        view.alpha = 0.5
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 50),
            animationView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        animationView.stop()
    }

}
