//
//  CategoHeader.swift
//  Evento
//
//  Created by Sovorn on 11/28/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class CategoHeader: UITableViewHeaderFooterView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "You up for?"
        label.font = UIFont(name: boldFont, size: 40)
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupLabel()
    }
    
    private func setupLabel() {
        addSubview(titleLabel)
        
        titleLabel.anchor(top: self.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
