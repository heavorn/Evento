//
//  SettingController.swift
//  Evento
//
//  Created by Sovorn on 11/30/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class SettingController: UIViewController {
    
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(handleDismiss))
        if let titleName = name {
            self.navigationItem.title = titleName
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.mainColor()]
        }
    }
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
