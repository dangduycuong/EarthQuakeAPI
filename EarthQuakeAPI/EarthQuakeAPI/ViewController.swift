//
//  ViewController.swift
//  EarthQuakeAPI
//
//  Created by duycuong on 4/25/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive || $0.activationState == .foregroundInactive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first else {
            return
        }
        let vc = QuakeListViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.setNavigationBarHidden(true, animated: false)
        keyWindow.rootViewController = navigationController
        keyWindow.makeKeyAndVisible()
    }
}
