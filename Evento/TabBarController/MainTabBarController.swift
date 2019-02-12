//
//  MainTabBarController.swift
//  Evento
//
//  Created by Sovorn on 11/22/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true)
            }
            return
        }
        
        setupViewController()
    }
    
    func setupViewController() {
        
//        UserDefaults.standard.set(true, forKey: "login")
        UserDefaults.standard.set("Phnom Penh", forKey: "city")
        UserDefaults.standard.set("All", forKey: "type")
        posts.removeAll()
        
        //Home
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //Search
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //Noti
        
        let NotiNavController = templateNavController(unselectedImage: UIImage(named: "like_unselected")!, selectedImage: UIImage(named: "like_selected")!, rootViewController: NotiController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //User profile
        let userProfileController = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        let profileNavControlller = UINavigationController(rootViewController: userProfileController)
        profileNavControlller.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        profileNavControlller.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = UIColor.mainColor()
        
        viewControllers = [homeNavController, searchNavController, NotiNavController, profileNavControlller]
        
        tabBar.items?.forEach{
            $0.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    private func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        
        return navController
    }
}
