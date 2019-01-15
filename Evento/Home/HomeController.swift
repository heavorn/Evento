//
//  HomeController.swift
//  Evento
//
//  Created by Sovorn on 11/22/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

var posts = [Post]()

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let gourp = DispatchGroup()
    
//    var posts = [Post]()
    var filters = [Post]()
    
    let headId = "headId"
    let cellId = "cellId"
    
    var cityName: String?
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityName = UserDefaults.standard.string(forKey: "city")
        type = UserDefaults.standard.string(forKey: "type")
        fetchUserID()
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headId)
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func fetchUserID() {
        Spinner.start()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.fetchPost(user: user, location: self.cityName!, type: self.type!)
        }
    }
    
    func fetchPost(user: User,  location: String, type: String) {
        
        if posts.count == 0 {
            let ref = Database.database().reference()
            ref.child("posts").observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: Any] else {return}
                dictionary.forEach({ (key, value) in
                    if let dic = value as? [String: Any] {
                        let post = Post(dictionary: dic, user: user)
                        post.id = key
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.dateFormat = "dd MM, yyyy"
//                        let date = dateFormatter.date(from: "\(post.day!) \(post.month!), 2018")
                        post.date = convertDate(month: post.month!, day: post.day!)
                        posts.append(post)
                        posts.sort(by: { (p1, p2) -> Bool in
                            return p1.date?.compare(p2.date!) == .orderedAscending
                        })
                        self.appendFilter(location: location, type: type)
                    }
                })
            }, withCancel: nil)
        } else {
            self.appendFilter(location: location, type: type)
//            self.filters.removeAll()
//            var index = 0
//            while index < posts.count {
//                if posts[index].city == location {
//                    self.filters.append(posts[index])
//                }
//                index = index + 1
//                self.collectionView.reloadData()
//            }
        }
        Spinner.stop()
    }
    
    func appendFilter(location: String, type: String) {
        self.filters.removeAll()
        var index = 0
        if type == "All" {
            while index < posts.count {
                if posts[index].city == location {
                    self.filters.append(posts[index])
                }
                index = index + 1
                self.collectionView.reloadData()
            }
        } else {
            while index < posts.count {
                if posts[index].city == location && posts[index].type == type {
                    self.filters.append(posts[index])
                }
                index = index + 1
                self.collectionView.reloadData()
            }
        }
    }
    
    func presentLocationController() {
        let locationController = LocationController()
        locationController.homeController = self
        locationController.fromHome = true
        locationController.titleLabel.isHidden = true
        locationController.currentButton.isHidden = true
        locationController.popularLabel.isHidden = true
        present(locationController, animated: true)
//        self.navigationController?.pushViewController(locationController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headId, for: indexPath) as! HomeHeader
        header.homeController = self
        header.locationButton.titleLabel?.text = cityName
        header.locationButton.underLine()
        
        return header
    }
    
    lazy var postProfile: PostProfile = {
        let luncher = PostProfile()
        
        return luncher
    }()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        postProfile.post = filters[indexPath.row]
        postProfile.handleMore()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        
        return CGSize(width: view.frame.width, height: view.frame.height / 1.15)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        return posts.count
        return filters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
//        cell.post = posts[indexPath.row]
        cell.post = filters[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 24, height: view.frame.height * 1.2 / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y < 0 {
            collectionView.contentOffset.y = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UIApplication.shared.statusBarView?.backgroundColor = .mainColor()
    }
    
}
