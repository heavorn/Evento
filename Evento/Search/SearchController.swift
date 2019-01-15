//
//  SearchController.swift
//  Evento
//
//  Created by Sovorn on 11/22/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController {
    
    var eventFilter = [Post]()
    
    let locationTitle: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.font = UIFont(name: font, size: 18)
        label.textColor = .lightGray
        label.textAlignment = .center
        
        return label
    }()
    
//    let dateTitle: UILabel = {
//        let label = UILabel()
//        label.text = "Date"
//        label.font = UIFont(name: font, size: 18)
//        label.textColor = .lightGray
//        label.textAlignment = .center
//
//        return label
//    }()
    
    let categoTitle: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = UIFont(name: font, size: 18)
        label.textColor = .lightGray
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var location: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Phnom Penh"
        label.textAlignment = .center
        label.underline()
        label.font = UIFont(name: boldFont, size: 30)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLocationController)))
        
        return label
    }()
    
    @objc func handleLocationController(sender: UITapGestureRecognizer) {
        let locationController = LocationController()
        locationController.searchController = self
        self.navigationController?.pushViewController(locationController, animated: true)
    }
    
//    lazy var date: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.text = "Anytime"
//        label.textAlignment = .center
//        label.underline()
//        label.font = UIFont(name: boldFont, size: 30)
//        label.isUserInteractionEnabled = true
//        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDateController)))
//
//        return label
//    }()
//
//    @objc func handleDateController(sender: UITapGestureRecognizer) {
//        let dateController = DateController()
//        dateController.searchController = self
//        self.navigationController?.pushViewController(dateController, animated: true)
//    }
    
    lazy var catego: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "All"
        label.textAlignment = .center
        label.underline()
        label.font = UIFont(name: boldFont, size: 30)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCategoController)))
        
        return label
    }()
    
    @objc func handleCategoController(sender: UITapGestureRecognizer) {
        let categoController = CategoController()
        categoController.searchController = self
        self.navigationController?.pushViewController(categoController, animated: true)
    }
    
    let backgroundImage: UIImageView = {
        let iv = UIImageView()
//        iv.contentMode = .scaleToFill
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainColor()
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont(name: boldFont, size: 22)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleSearch() {
        self.eventFilter.removeAll()
        var index = 0
        if catego.text == "All" {
            while index < posts.count {
                if posts[index].city == location.text {
                    self.eventFilter.append(posts[index])
                }
                index = index + 1
                self.collectionView.reloadData()
            }
        } else {
            while index < posts.count {
                if posts[index].city == location.text && posts[index].type == catego.text {
                    self.eventFilter.append(posts[index])
                }
                index = index + 1
                self.collectionView.reloadData()
            }
        }
        
        let searchListController = SearchList(collectionViewLayout: UICollectionViewFlowLayout())
        searchListController.filterEvent = eventFilter
        searchListController.searchBar.isHidden = true
        self.navigationController?.pushViewController(searchListController, animated: true)
        
    }
    
    let buttonSearch: ButtonWithImage = {
        let button = ButtonWithImage()
        let image = UIImage(named: "search_button")
        button.setImage(image, for: .normal)
        button.layer.masksToBounds = true
        
        button.setTitle("Search for events...", for: .normal)
        button.titleLabel?.font = UIFont(name: boldFont, size: 22)
        button.underLine()
        
        button.addTarget(self, action: #selector(handlePushSearchList), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handlePushSearchList() {
        let searchListController = SearchList(collectionViewLayout: UICollectionViewFlowLayout())
        searchListController.searchBar.isHidden = false
        self.navigationController?.pushViewController(searchListController, animated: true)
    }
    
    let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Search for events..."
        label.font = UIFont(name: boldFont, size: 22)
        label.textColor = .white
        label.underline()
        
        return label
    }()
    
    
    let searchImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "search_selected")?.withRenderingMode(.alwaysTemplate)
        iv.image = iv.image?.imageWithColor(color1: .white)
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setupHeader()
        setupBody()
    }
    
    private func setupBody() {
        collectionView.addSubview(locationTitle)
        collectionView.addSubview(location)
//        collectionView.addSubview(dateTitle)
//        collectionView.addSubview(date)
        collectionView.addSubview(categoTitle)
        collectionView.addSubview(catego)
        collectionView.addSubview(searchButton)
        
        locationTitle.anchor(top: backgroundImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        locationTitle.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
        location.anchor(top: locationTitle.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        location.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
//        dateTitle.anchor(top: location.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        dateTitle.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
//
//        date.anchor(top: dateTitle.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        date.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
        categoTitle.anchor(top: location.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        categoTitle.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
        catego.anchor(top: categoTitle.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        catego.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
        searchButton.anchor(top: catego.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 40)
        searchButton.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
    }
    
    private func setupHeader(){
        
        let height: CGFloat = collectionView.frame.height
        
        collectionView.addSubview(backgroundImage)
        collectionView.addSubview(buttonSearch)
        
        if collectionView.frame.width > 375 {
            backgroundImage.image = UIImage(named: "searchBackground")
        } else {
            backgroundImage.image = UIImage(named: "searchBackground2")
        }
        
        backgroundImage.anchor(top: collectionView.safeAreaLayoutGuide.topAnchor, left: collectionView.leftAnchor, bottom: nil, right: collectionView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: height * 0.35)
        
        buttonSearch.anchor(top: collectionView.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: height * 0.35 * 0.3, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: collectionView.frame.width - 60, height: 0)
        buttonSearch.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor).isActive = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.isNavigationBarHidden = false
    }
}
