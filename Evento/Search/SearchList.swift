//
//  SearchList.swift
//  Evento
//
//  Created by Sovorn on 11/27/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class SearchList: UICollectionViewController, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    var bottomConstraint: NSLayoutConstraint?
    
    let cellId = "cellId"
    
    var filterEvent = posts
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.delegate = self
        sb.placeholder = "Search for events..."
        
        return sb
    }()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filterEvent = posts
        } else {
            filterEvent = posts.filter { (post) -> Bool in
                return (post.name?.lowercased().contains(searchText.lowercased()))!
            }
        }
        self.collectionView.reloadData()
    }
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.tintColor = .mainColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.becomeFirstResponder()
        
        collectionView.backgroundColor = .mainColor()
        collectionView.alwaysBounceVertical = true
        
        collectionView.keyboardDismissMode = .onDrag
        
        collectionView.register(SearchListCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupSearchBar()
        
    }
    
    private func setupSearchBar() {
        
        let navBar = navigationController?.navigationBar
        navBar?.addSubview(searchBar)
        searchBar.changeSearchBarColor(color: UIColor.rgb(red: 240, green: 240, blue: 240))
        
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 16, width: 0, height: 0  )
        
//        collectionView.addSubview(searchButton)
//
//        searchButton.frame = CGRect(x: 0, y: collectionView.frame.height, width: 80, height: 0)
//
//        searchButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
//        searchButton.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
//        bottomConstraint = searchButton.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
//        bottomConstraint?.isActive = true
        
    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardHeight = keyboardFrame.cgRectValue.height
//            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                self.bottomConstraint?.isActive = false
//                self.bottomConstraint?.constant = -keyboardHeight + 30
//                self.bottomConstraint?.isActive = true
//                self.view.layoutIfNeeded()
//            }, completion: nil)
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification){
//
//        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.bottomConstraint?.isActive = false
//            self.bottomConstraint?.constant = -20
//            self.bottomConstraint?.isActive = true
//            self.view.layoutIfNeeded()
//        }, completion: nil)
//    }
    
    lazy var postProfile: PostProfile = {
        let luncher = PostProfile()
        
        return luncher
    }()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.searchBar.endEditing(true)
        postProfile.post = filterEvent[indexPath.row]
        postProfile.handleMore()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return filterEvent.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchListCell
        cell.post = filterEvent[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        self.searchBar.isHidden = false
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = .mainColor()
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.searchBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .default

    }
}
