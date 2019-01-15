//
//  LocationCell.swift
//  Evento
//
//  Created by Sovorn on 11/28/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
    
    var name: String? {
        didSet {
            guard let placesName = name else {return}
            self.placeLabel.text = placesName
        }
    }
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: boldFont, size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        addSubview(placeLabel)
        
        placeLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        placeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
