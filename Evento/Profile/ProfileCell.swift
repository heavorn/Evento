//
//  ProfileCell.swift
//  Evento
//
//  Created by Sovorn on 11/22/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    var setting: Setting? {
        didSet{
            ImageView.image = UIImage(named: setting!.imageName)
            ImageView.image = ImageView.image?.imageWithColor(color1: UIColor.mainColor())
            titleLabel.text = setting?.titleName
        }
    }
    
    let ImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "setting"))
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont(name: font, size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(ImageView)
        addSubview(titleLabel)
        
        ImageView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        titleLabel.anchor(top: nil, left: ImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 2, paddingRight: 0, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
