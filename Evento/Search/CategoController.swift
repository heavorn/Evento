//
//  CategoController.swift
//  Evento
//
//  Created by Sovorn on 11/28/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class CategoController:  UITableViewController {
    
    var searchController: SearchController?
    var lastIndexPath: IndexPath?
    var isScroll = true
    
    let cellId = "cellId"
    let headId = "headId"
    
//    let placesList = ["All", "Business", "Technology", "Art & Entertainment", "Educaton", "Health & Wellness" , "Culture", "Sports", "Science", "DIY", "Party", "Music"]
    
    let placesList = ["Bus", "Tech", "Edu", "Art", "Music", "Sport"]
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "You up for?"
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.backgroundColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(LocationCell.self, forCellReuseIdentifier: cellId)
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        setupLabel()
    }
    
    private func setupLabel() {
        tableView.addSubview(titleLabel)
        
        titleLabel.anchor(top: tableView.safeAreaLayoutGuide.topAnchor, left: tableView.leftAnchor, bottom: nil, right: tableView.rightAnchor, paddingTop: -50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: tableView.frame.width, height: 115)
        
//        titleLabel.anchor(top: tableView.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        titleLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LocationCell
        cell.name = placesList[indexPath.row]
        if placesList[indexPath.row] == searchController?.catego.text {
            cell.accessoryType = .checkmark
            if isScroll == true {
                lastIndexPath = indexPath
                isScroll = false
            }
        }
        
        cell.selectionStyle = .none
        cell.tintColor = .mainColor()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let index = lastIndexPath {
            tableView.scrollToRow(at: index, at: .top, animated: true)
            lastIndexPath = nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchController?.catego.text = placesList[indexPath.row]
        self.searchController?.catego.underline()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y < -138 {
            tableView.contentOffset.y = -138
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.tintColor = .mainColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headId) as! CategoHeader
    //        header.contentView.backgroundColor = .white
    //
    //        return header
    //    }
    //
    //    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 80
    //    }
    //
}
