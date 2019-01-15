//
//  HomeHeaderCell.swift
//  Evento
//
//  Created by Sovorn on 11/25/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class HomeHeaderCell: UICollectionViewCell {
    
//    let outerView: UIView = {
//        let view = UIView()
//        view.clipsToBounds = false
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOpacity = 1
//        view.layer.shadowOffset = CGSize.zero
//        view.layer.shadowRadius = 12
//        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 12).cgPath
//        view.backgroundColor = .blue
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//    }()
    
//    let imageView: UIImageView = {
//        let iv = UIImageView()
//        iv.image = UIImage(named: "ignite")
//        iv.layer.cornerRadius = 12
//        iv.clipsToBounds = true
//        return iv
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - 10))
        outerView.layer.shadowColor = UIColor(white: 0, alpha: 0.4).cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
//        outerView.layer.shadowRadius = 20
        outerView.clipsToBounds = false
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 22).cgPath
//        outerView.layer.shadowPath = UIBezierPath(rect: outerView.bounds).cgPath
        
        addSubview(outerView)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ignite")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        
        outerView.addSubview(imageView)
        
        imageView.anchor(top: outerView.topAnchor, left: outerView.leftAnchor, bottom: outerView.bottomAnchor, right: outerView.rightAnchor, paddingTop: 2, paddingLeft: -4, paddingBottom: 5, paddingRight: -4, width: 0, height: 0)
        
        
//        addSubview(imageView)
//        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
