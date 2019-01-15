//
//  HomeCell.swift
//  Evento
//
//  Created by Sovorn on 11/24/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let eventUrl = post?.eventUrl, let name = post?.name, let time = post?.time, let month = post?.month, let day = post?.day, let location = post?.location, let city = post?.city, let phone = post?.phone, let type = post?.type else {return}
            
            imageView.loadImage(urlString: eventUrl)
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 18
            
            let attribute1 = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont(name: boldFont, size: 18)!])
            
            attribute1.append(NSMutableAttributedString(string: "\n\n\(time)", attributes: [NSAttributedString.Key.font: UIFont(name: font, size: 12)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            attribute1.append(NSMutableAttributedString(string: "\n\(location), \(city)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
//            attribute1.append(NSMutableAttributedString(string: "\nFree", attributes: [NSAttributedString.Key.font: UIFont(name: font, size: 11)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            desTextView.attributedText = attribute1
            
            let attribute2 = NSMutableAttributedString(string: month, attributes: [NSAttributedString.Key.font: UIFont(name: boldFont, size: 18)!, NSAttributedString.Key.foregroundColor: UIColor.mainColor()])
            attribute2.append(NSAttributedString(string: "\n\n \(day)", attributes: [NSAttributedString.Key.font: UIFont(name: boldFont, size: 18)!]))
            
            dateTextView.attributedText = attribute2
        }
    }
    
    let dateTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.isScrollEnabled = false
        
        return tv
    }()
    
    let desTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.isScrollEnabled = false
        
        return tv
    }()
    
    let imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = UIColor(white: 1, alpha: 0.8)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 18
        
        return iv
    }()
    
//    let outerView: UIView = {
//        let iv = UIView()
//        iv.layer.shadowColor = UIColor(white: 0, alpha: 0.4).cgColor
//        iv.layer.shadowOpacity = 1
//        iv.layer.shadowOffset = CGSize.zero
//        iv.clipsToBounds = false
//        iv.layer.shadowPath = UIBezierPath(roundedRect: iv.bounds, cornerRadius: 22).cgPath
//
//        return iv
//    }()
    
    let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 2.1 / 3))
        outerView.layer.shadowColor = UIColor(white: 0, alpha: 0.6).cgColor
        outerView.layer.shadowOpacity = 0.6
        outerView.layer.shadowOffset = CGSize.zero
        outerView.clipsToBounds = false
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 16).cgPath
        
        addSubview(outerView)

//        addSubview(imageView)
        addSubview(separateLine)
        addSubview(dateTextView)
        addSubview(desTextView)
        
        outerView.addSubview(imageView)
        
        
        
//        outerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: self.frame.height * 0.9 / 3, paddingRight: 0, width: 0, height: 0)
//        outerView.addSubview(imageView)
        
        imageView.anchor(top: outerView.topAnchor, left: outerView.leftAnchor, bottom: outerView.bottomAnchor, right: outerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        separateLine.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 1)
        
        dateTextView.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 4, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 60, height: 0)
        
        desTextView.anchor(top: dateTextView.topAnchor, left: dateTextView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
