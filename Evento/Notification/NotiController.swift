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
    
    var notiPosts = [Post]()
    
    let refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    @objc func handleRefresh() {
        notiPosts.removeAll()
        fetchBookedEvents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchBookedEvents()
        
        collectionView.backgroundColor = .white
        collectionView.register(NotiCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.refreshControl = refresh
        
    }
    
    private func fetchBookedEvents() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
    Database.database().reference().child("books").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
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
        self.collectionView?.refreshControl?.endRefreshing()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return notiPosts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NotiCell
        cell.post = notiPosts[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 80)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}
