//
//  NotiController.swift
//  Evento
//
//  Created by Sovorn on 11/22/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

class NotiController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let notiId = "notiId"
    
    var notiPosts = [Post]()
    var notiOrganizers = [Noti]()
    
    let group = DispatchGroup()
    
    
//    let refresh: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
//
//        return refreshControl
//    }()
//
//    @objc func handleRefresh() {
//        notiPosts.removeAll()
//        fetchBookedEvents()
//    }
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchBookedEvents()
        
        collectionView.backgroundColor = .white
        collectionView.register(NotiCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(OrganizerCell.self, forCellWithReuseIdentifier: notiId)
        collectionView.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 70, right: 0)
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.refreshControl = refresh
        
        setupSement()
        
    }
    
    private func setupSement(){
        collectionView.addSubview(container)
        container.addSubview(notificationSegmentController)
        
        container.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        
        notificationSegmentController.anchor(top: container.topAnchor, left: container.leftAnchor, bottom: nil, right: container.rightAnchor, paddingTop: 5, paddingLeft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 50)
    }
    
    let notificationSegmentController: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Organizer", "User"])
        sc.selectedSegmentIndex = 1
        sc.tintColor = .mainColor()
        sc.addTarget(self, action: #selector(handleSegment), for: .valueChanged)
        
        return sc
    }()
    
    @objc func handleSegment() {
        notiPosts.removeAll()
        notiOrganizers.removeAll()
        fetchBookedEvents()
    }
    
    private func fetchBookedEvents() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference()
        if notificationSegmentController.selectedSegmentIndex == 0 {
            print("Organizer")
            ref.child("organizers").child(uid).observe(.childAdded, with: { (snapshot) in
                ref.child("organizers").child(uid).child(snapshot.key).observeSingleEvent(of: .value, with: { (gg) in
                    guard let dictionary = gg.value as? [String: Any] else {return}
                    dictionary.forEach({ (key, value) in
                        self.group.enter()
                        Database.fetchUserWithUID(uid: key, completion: { (user) in
                            let noti = Noti(name: snapshot.key, user: user, time: value)
                            self.notiOrganizers.append(noti)
                            self.notiOrganizers.sort(by: { (noti1, noti2) -> Bool in
                                return noti1.date?.compare(noti2.date!) == .orderedDescending
                            })
                            self.group.leave()
                        })
//                        self.group.leave()
                        self.group.notify(queue: .main, execute: {
                            self.collectionView.reloadData()
                        })
                    })
                }, withCancel: nil)
            }, withCancel: nil)
            
//            self.group.notify(queue: .main) {
////                print(self.notiOrganizers[2].postName)
//                print("2")
//            }
        } else {
            print("User")
            ref.child("books").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dic = snapshot.value as? [String: Any] else {return}
                dic.forEach({ (key, value) in
                    //
                    posts.forEach({ (post) in
                        if (post.id == key) {
                            post.date = convertDate(month: post.month!, day: post.day!)
                            self.notiPosts.append(post)
                            self.notiPosts.sort(by: { (p1, p2) -> Bool in
                                return p1.date?.compare(p2.date!) == .orderedAscending
                            })
                        }
                    })
                    self.collectionView.reloadData()
                    //
                })
            }, withCancel: nil)
//            self.collectionView?.refreshControl?.endRefreshing()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if notificationSegmentController.selectedSegmentIndex == 1{
            return notiPosts.count
        } else {
            return notiOrganizers.count
        }
//        return notiPosts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if notificationSegmentController.selectedSegmentIndex == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NotiCell
            cell.post = notiPosts[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: notiId, for: indexPath) as! OrganizerCell
            cell.noti = notiOrganizers[indexPath.row]
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 80)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}
