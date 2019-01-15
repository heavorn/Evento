//
//  LocationController.swift
//  Evento
//
//  Created by Sovorn on 11/28/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class LocationController: UITableViewController {
    
//    var lastSelectedIndexPath = NSIndexPath(row: -1, section: 0)
//    var lastSelection: IndexPath?
    
    var searchController: SearchController?
    
    var homeController: HomeController?
    
    var fromHome: Bool?
    
    let cellId = "cellId"
    let placesList = ["Phnom Penh", "Battambang", "Kampot", "Sihanoukville", "Siem Reap"]
    
    var selectedLocation: String?
    
    let popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular places"
        label.textColor = .lightGray
        label.font = UIFont(name: font, size: 14)
        
        return label
    }()
    
    let currentButton: ButtonWithImage = {
        let button = ButtonWithImage()
        let image = UIImage(named: "gps")
        button.setImage(image, for: .normal)
        button.layer.masksToBounds = true
        
        button.setTitle("Use my current location", for: .normal)
        button.titleLabel?.font = UIFont(name: font, size: 16)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Where?"
        label.font = UIFont(name: boldFont, size: 40)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(LocationCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 110, left: 0, bottom: 100, right: 0)
        tableView.isScrollEnabled = false
        
        if fromHome == true {
            selectedLocation = UserDefaults.standard.string(forKey: "city")
        } else {
            selectedLocation = searchController?.location.text
        }
        
        setupLabel()
    }
    
    private func setupLabel() {
        tableView.addSubview(titleLabel)
        tableView.addSubview(currentButton)
        tableView.addSubview(popularLabel)
        
        titleLabel.anchor(top: tableView.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        titleLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        
        currentButton.anchor(top: titleLabel.bottomAnchor, left: tableView.leftAnchor, bottom: nil, right: tableView.rightAnchor, paddingTop: 12, paddingLeft: -30, paddingBottom: 0, paddingRight: 0, width: 300, height: 0)
        
        popularLabel.anchor(top: currentButton.bottomAnchor, left: tableView.leftAnchor, bottom: nil, right: tableView.rightAnchor, paddingTop: 12, paddingLeft: 33, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LocationCell
        cell.name = placesList[indexPath.row]
        if placesList[indexPath.row] == selectedLocation {
            cell.accessoryType = .checkmark
//            self.lastSelection = indexPath
        }
        cell.selectionStyle = .none
        cell.tintColor = .mainColor()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if fromHome == true {
            UserDefaults.standard.set(placesList[indexPath.row], forKey: "city")
            UserDefaults.standard.set("All", forKey: "type")
            fromHome = false
            dismiss(animated: true) {
                self.homeController?.cityName = self.placesList[indexPath.row]
                self.homeController?.type = "All"
                self.homeController?.fetchUserID()
            }
        } else {
            //        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.searchController?.location.text = placesList[indexPath.row]
            self.searchController?.location.underline()
            //        self.lastSelection = indexPath
            self.navigationController?.popViewController(animated: true)
        }

    }
    
//    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//
//        if let selectedIndex = self.lastSelection {
//            self.tableView.deselectRow(at: selectedIndex, animated: false)
//            self.tableView.cellForRow(at: selectedIndex)?.accessoryType = .none
//        }
//
//        return indexPath
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.tintColor = .mainColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.currentButton.isHidden = false
        self.titleLabel.isHidden = false
        self.popularLabel.isHidden = false
    }
}
