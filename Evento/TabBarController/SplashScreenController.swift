//
//  SplashScreenController.swift
//  Evento
//
//  Created by Sovorn Chea on 1/25/19.
//  Copyright © 2019 Sovorn. All rights reserved.
//

import UIKit

class SplashScreenController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.splashTimeOut(sender:)), userInfo: nil, repeats: false)
        
        view.backgroundColor = .mainColor()
    }
    
    @objc func splashTimeOut(sender : Timer){
        AppDelegate.sharedInstance().window?.rootViewController = MainTabBarController()
    }
}
