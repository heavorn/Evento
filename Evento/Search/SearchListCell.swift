//
//  SearchListCell.swift
//  Evento
//
//  Created by Sovorn on 1/13/19.
//  Copyright © 2019 Sovorn. All rights reserved.
//

import UIKit

class SearchListCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let profileUrl = post?.eventUrl, let title = post?.name, let date = post?.time else {return}
            
            self.eventProfile.loadImage(urlString: profileUrl)
            self.title.text = title
            self.date.text = date
        }
    }
    
    let eventProfile: CustomImageView = {
        let iv = CustomImageView()
        iv.image = UIImage(named: "bus")
        iv.layer.cornerRadius = 5
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "TeDx"
        label.textColor = .black
        label.font = UIFont(name: boldFont, size: 18)
        
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.text = "Apr 06, 2019. 8:00a.m"
        label.textColor = .gray
        label.font = UIFont(name: font, size: 14)
        
        return label
    }()
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.9)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        setupLayout()
    }
    
    func setupLayout() {
        addSubview(container)
        
        container.addSubview(eventProfile)
        
        let stackView = UIStackView(arrangedSubviews: [title, date])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        
        container.addSubview(stackView)
        
        container.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        eventProfile.anchor(top: container.topAnchor, left: container.leftAnchor, bottom: container.bottomAnchor, right: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 0, width: (self.frame.width - 16) / 3, height: 0)
        
        stackView.anchor(top: container.topAnchor, left: eventProfile.rightAnchor, bottom: container.bottomAnchor, right: container.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
