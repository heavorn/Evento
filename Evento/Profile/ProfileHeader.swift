//
//  ProfileHeaderController.swift
//  Evento
//
//  Created by Sovorn on 11/22/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

class ProfileHeader: UICollectionViewCell {
    
    var user: User? {
        didSet {
            guard let name = user?.name, let email = user?.email, let profile = user?.profileUrl, let phone = user?.phone else {return}
            
            profileImageView.loadImage(urlString: profile)
            profileImageView.layer.cornerRadius = 50
            profileImageView.layer.masksToBounds = true
            profileImageView.layer.borderColor = UIColor.white.cgColor
            profileImageView.layer.borderWidth = 3
            
            emailLabel.text = email
            emailLabel.font = UIFont(name: font, size: 15)
            
            callLabel.text = phone
            callLabel.font = UIFont(name: font, size: 15)
            
            nameLabel.text = name
            
        }
    }
    
    let container1: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let container2: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let emailLabel: UITextView = {
        let label = UITextView()
        label.textColor = .lightGray
        label.isEditable = false
        label.isScrollEnabled = false
        
        return label
    }()
    
    let callLabel: UITextView = {
        let label = UITextView()
        label.textColor = .lightGray
        label.isEditable = false
        label.isScrollEnabled = false
        
        return label
    }()
    
    let emailImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "email")
        iv.image = iv.image?.imageWithColor(color1: UIColor.rgb(red: 224, green: 83, blue: 83, alpha: 0.5))
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    let callImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "call")
        iv.image = iv.image?.imageWithColor(color1: UIColor.rgb(red: 224, green: 83, blue: 83, alpha: 0.5))
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    let nameLabel: UITextView = {
        let label = UITextView()
        label.textColor = .white
        label.font = UIFont(name: boldFont, size: 22)
        label.isEditable = false
        label.isScrollEnabled = false
        label.backgroundColor = .clear
        
        return label
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleDone() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let values = ["name": nameLabel.text, "email": emailLabel.text, "profileUrl": user?.profileUrl, "phone": callLabel.text]
        
        registerUserIntoDatabase(id: uid, values: values as [String : AnyObject])
        
        doneButton.isHidden = true
        editButton.isHidden = false
        
        emailLabel.layer.borderColor = UIColor.white.cgColor
        emailLabel.isEditable = false
        
        callLabel.layer.borderColor = UIColor.white.cgColor
        callLabel.isEditable = false
        
        nameLabel.isEditable = false
    }
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        var image = UIImage(named: "edit")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleEdit() {
        editButton.isHidden = true
        doneButton.isHidden = false
        
        emailLabel.layer.cornerRadius = 5
        emailLabel.layer.masksToBounds = true
        emailLabel.layer.borderColor = UIColor.mainColor().cgColor
        emailLabel.layer.borderWidth = 1
        emailLabel.isEditable = true
        
        callLabel.layer.cornerRadius = 5
        callLabel.layer.masksToBounds = true
        callLabel.layer.borderColor = UIColor.mainColor().cgColor
        callLabel.layer.borderWidth = 1
        callLabel.isEditable = true
        
        nameLabel.isEditable = true
    }
    
    
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 50
        iv.layer.masksToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 3
        iv.backgroundColor = .lightGray
        
        return iv
    }()
    
    let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    let backgroundImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundImage.image = UIImage(named: "headerBackground")
        backgroundImage.contentMode = .scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)
        
        let stackView = UIStackView(arrangedSubviews: [container1, container2])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        addSubview(profileImageView)
        addSubview(editButton)
        addSubview(doneButton)
        addSubview(nameLabel)
        addSubview(stackView)
        
        addSubview(separateLine)
        
        container1.addSubview(callImageView)
        container1.addSubview(callLabel)
        container2.addSubview(emailImageView)
        container2.addSubview(emailLabel)
        
        
        backgroundImage.anchor(top: self.safeAreaLayoutGuide.topAnchor  , left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 80, paddingRight: 0, width: 0, height: 0)
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: self.frame.height / 4, paddingLeft: self.frame.width / 4, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        
        doneButton.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 50, height: 20)
        
        editButton.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 25, height: 25)
        
        nameLabel.anchor(top: nil, left: profileImageView.rightAnchor, bottom: profileImageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
        
        separateLine.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 1)
        
        stackView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 45, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        
        callImageView.anchor(top: container1.topAnchor, left: container1.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        callLabel.anchor(top: container1.topAnchor, left: callImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 150, height: 0)
        
        emailImageView.anchor(top: container2.topAnchor, left: container2.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        emailLabel.anchor(top: container2.topAnchor, left: emailImageView.rightAnchor, bottom: nil, right: container2.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
    }
    
    private func registerUserIntoDatabase(id: String, values: [String : AnyObject]){
        
        Database.database().reference().child("users").child(id).updateChildValues(values, withCompletionBlock: { (error, ref) in
            if (error != nil){
                print(error!)
                return
            }
            print("Upload Successfully!")
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
