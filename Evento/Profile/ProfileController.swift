//
//  ProfileController.swift
//  Evento
//
//  Created by Sovorn on 11/22/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

let statusBarSize = UIApplication.shared.statusBarFrame.size
let statusBarHeight = Swift.min(statusBarSize.width, statusBarSize.height)

class ProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user: User?
    
    let cellId = "cellId"
    let headId = "headId"
    let footId = "foodId"
    
    let settings = [Setting(image: "favorite", title: "Your Favorite"), Setting(image: "promotion", title: "Promotion"), Setting(image: "manage", title: "Manage Events"), Setting(image: "help", title: "FAQs"), Setting(image: "setting", title: "Settings")]
    
    let footer: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = UIFont(name: boldFont, size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.mainColor(), for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleLogout(){
        let ac = UIAlertController()
        ac.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true)
            } catch let singOut {
                print("Error sign out", singOut)
            }
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        //        ac.view.tintColor = .black
        present(ac, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let title = settings[indexPath.row].titleName
        
        if title != "Manage Events" {
            let settingController = SettingController()
            settingController.name = title
            present(UINavigationController(rootViewController: settingController), animated: true)
        } else {
            let manageController = ManageEventController()
            manageController.name = title
            present(UINavigationController(rootViewController: manageController), animated: true)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        
        collectionView.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headId)
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.addSubview(footer)
        collectionView.addSubview(separateLine)
        
        separateLine.anchor(top: nil, left: view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 60, paddingBottom: 50, paddingRight: 60, width: 0, height: 1)
        
        footer.anchor(top: separateLine.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        footer.addSubview(logoutButton)
        
        logoutButton.centerXAnchor.constraint(equalTo: footer.centerXAnchor).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: footer.centerYAnchor).isActive = true
        
    }
    
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.user = user
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headId, for: indexPath) as! ProfileHeader
        header.user = self.user

        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height / 2.8)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileCell
        cell.setting = settings[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    
}
