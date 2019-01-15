//
//  DateController.swift
//  Evento
//
//  Created by Sovorn on 11/28/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class DateController:  UITableViewController {
    
//    var searchController: SearchController?
//    
//    let cellId = "cellId"
//    let placesList = ["Anytime", "Today", "Tomorrow", "This Weekend", "In the next month", "Pick a date..."]
//    
//    
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "What time?"
//        label.font = UIFont(name: boldFont, size: 40)
//        
//        return label
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.register(LocationCell.self, forCellReuseIdentifier: cellId)
//        tableView.separatorStyle = .none
//        tableView.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 100, right: 0)
//        tableView.isScrollEnabled = false
//        
//        setupLabel()
//    }
//    
//    private func setupLabel() {
//        tableView.addSubview(titleLabel)
//        
//        titleLabel.anchor(top: tableView.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        titleLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return placesList.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LocationCell
//        cell.name = placesList[indexPath.row]
//        if placesList[indexPath.row] == searchController?.date.text {
//            cell.accessoryType = .checkmark
//        }
//        cell.selectionStyle = .none
//        cell.tintColor = .mainColor()
//        
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.searchController?.date.text = placesList[indexPath.row]
//        self.searchController?.date.underline()
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        navigationController?.navigationBar.tintColor = .mainColor()
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
//    }
}
