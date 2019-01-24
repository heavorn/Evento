//
//  OrganizerCell.swift
//  Evento
//
//  Created by Sovorn Chea on 1/22/19.
//  Copyright © 2019 Sovorn. All rights reserved.
//

import UIKit

class OrganizerCell: UICollectionViewCell {
    
    var noti: Noti? {
        didSet {
            guard let userProfile = noti?.user?.profileUrl, let eventName = noti?.postName, let userName = noti?.user?.name, let time = noti?.date else {return}
            
            self.userProfile.loadImage(urlString: userProfile)
            self.title.text = "\(userName)'s booked your \(eventName) event."
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        setupLayout()
    }
    
    let userProfile: CustomImageView = {
        let iv = CustomImageView()
        iv.layer.cornerRadius = 5
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont(name: font, size: 15)
        
        return label
    }()
    
    let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        return view
    }()
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.9)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private func setupLayout() {
        addSubview(container)
        
        container.addSubview(userProfile)
        container.addSubview(title)
        container.addSubview(separateLine)
        
        container.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        userProfile.anchor(top: container.topAnchor, left: container.leftAnchor, bottom: container.bottomAnchor, right: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 0, width: (self.frame.width - 16) / 3, height: 0)
        
        title.anchor(top: nil, left: userProfile.rightAnchor, bottom: nil, right: container.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        title.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
        separateLine.anchor(top: nil, left: title.leftAnchor, bottom: container.bottomAnchor, right: title.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}