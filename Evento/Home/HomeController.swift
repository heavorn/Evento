//
//  HomeController.swift
//  Evento
//
//  Created by Sovorn on 11/22/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

var posts = [Post]()
//var users = [User]()]
var currentUser: User?

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var vorn = 2
    var vorn2 = 4
    
//    var posts = [Post]()
    var filters = [Post]()
    
    let headId = "headId"
    let cellId = "cellId"
    
    var cityName: String?
    var type: String?
    var isChanged = false
    
    var indicator: NVActivityIndicatorView?
    
    let welcomeBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .mainColor()

        return view
    }()
    
//    let blackLayer: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
//
//        return view
//    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "!Evento!"
        label.font = UIFont(name: boldFont, size: 50)
        label.textColor = .white
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            window.addSubview(welcomeBackground)
            welcomeBackground.frame = frame
            indicator = NVActivityIndicatorView.init(frame: CGRect(x: self.view.center.x - 40, y: self.view.center.y - 40, width: 80, height: 80), type: .ballClipRotatePulse, color: .white, padding: 0)
            welcomeBackground.addSubview(indicator!)
            welcomeBackground.addSubview(welcomeLabel)
            
            welcomeLabel.anchor(top: indicator?.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            welcomeLabel.centerXAnchor.constraint(equalTo: welcomeBackground.centerXAnchor).isActive = true
        }
        
//        view.addSubview(welcomeBackground)
//        welcomeBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        cityName = UserDefaults.standard.string(forKey: "city")
        type = UserDefaults.standard.string(forKey: "type")
//        fetchUserID()
        fetchUser()
        fetchPost()
//        fetchPost(location: self.cityName!, type: self.type!)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headId)
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        
//        view.addSubview(indicator)
//        indicator.startAnimating()
    }
    
    private func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            currentUser = user
        }
    }
    
//    func fetchUserID() {
//        Spinner.start()
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        Database.fetchUserWithUID(uid: uid) { (user) in
//            self.fetchPost(user: user, location: self.cityName!, type: self.type!)
//        }
//    }
    
//    let activityIndicatorView: NVActivityIndicatorView = {
//        let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), type: NVActivityIndicatorType.pacman, color: .mainColor(), padding: 0)
//
//        return indicator
//    }()
    
    func fetchPost() {
//        Spinner.start()
        
        self.welcomeBackground.alpha = 1
        indicator?.startAnimating()
        
        if posts.count == 0 {
            let ref = Database.database().reference()
            ref.child("posts").observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: Any] else {return}
                dictionary.forEach({ (key, value) in
                    if let dic = value as? [String: Any] {
                        let post = Post(dictionary: dic)
                        post.id = key
                        post.date = convertDate(month: post.month!, day: post.day!)
                        posts.append(post)
                        posts.sort(by: { (p1, p2) -> Bool in
                            return p1.date?.compare(p2.date!) == .orderedAscending
                        })
                        self.appendFilter(location: self.cityName!, type: self.type!)
                    }
                })
            }, withCancel: nil)
        } else {
            delay(bySeconds: 2) {
                self.appendFilter(location: self.cityName!, type: self.type!)
            }
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
    }
    
    func appendFilter(location: String, type: String) {
        self.filters.removeAll()
        var index = 0
        if type == "All" {
            print("OK")
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
//        self.welcomeBackground.layer.transform = CATransform3DMakeScale(1, 1, 1)
        indicator?.stopAnimating()
        if self.isChanged == true {
            self.welcomeBackground.alpha = 0
//            self.blackLayer.removeFromSuperview()
        } else {
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                self.welcomeBackground.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                self.welcomeBackground.alpha = 0.6
                
            }) { (completed) in
                delay(bySeconds: 0.4, closure: {
                    self.welcomeBackground.alpha = 0
                    self.welcomeBackground.backgroundColor = UIColor(white: 0, alpha: 0.5)
                    self.welcomeBackground.layer.transform = CATransform3DMakeScale(1, 1, 1)
                    self.welcomeLabel.removeFromSuperview()
                    self.isChanged = true
                })
            }
        }
        
        
//        welcomeBackground.isHidden = true
        
//        activityIndicatorView.stopAnimating()
//        Spinner.stop()
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
