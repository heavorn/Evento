//
//  ManageEventController.swift
//  Evento
//
//  Created by Sovorn on 11/30/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

class ManageEventController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    let group = DispatchGroup()
    
    var name: String?
    
    var maxTextViewWidth: CGFloat?
    
    let nameContainer: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.backgroundColor = .clear
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.masksToBounds = true
        
        return tf
    }()
    
    let timeContainer: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.backgroundColor = .clear
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.masksToBounds = true
        
        return tf
    }()
    
    let locationContainer: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.backgroundColor = .clear
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.masksToBounds = true
        
        return tf
    }()
    
    let cityContainer: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.backgroundColor = .clear
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.masksToBounds = true
        
        return tf
    }()
    
    let dateContainer: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.backgroundColor = .clear
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.masksToBounds = true
        
        return tf
    }()
    
    let dayContainer: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.backgroundColor = .clear
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.masksToBounds = true
        
        return tf
    }()
    
    let phoneContainer: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.backgroundColor = .clear
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.masksToBounds = true
        
        return tf
    }()
    
    let typeContainer: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.backgroundColor = .clear
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.masksToBounds = true
        
        return tf
    }()
    let containerView3: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let containerView2: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let containerView1: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let desTextView: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.backgroundColor = .clear
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.masksToBounds = true
        
        return tf
    }()
    
    let namePlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Event's name..."
        label.sizeToFit()
        label.textColor = .lightGray
        
        return label
    }()
    
    let timePlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Time..."
        label.sizeToFit()
        label.textColor = .lightGray
        
        return label
    }()
    
    let placePlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Location..."
        label.sizeToFit()
        label.textColor = .lightGray
        
        return label
    }()
    
    let phonePlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Phone number..."
        label.sizeToFit()
        label.textColor = .lightGray
        
        return label
    }()
    
    let desPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Description..."
        label.sizeToFit()
        label.textColor = .lightGray
        
        return label
    }()
    
    let typePlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Type..."
        label.sizeToFit()
        label.textColor = .lightGray
        
        return label
    }()
    
    let cityPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "City..."
        label.sizeToFit()
        label.textColor = .lightGray
        
        return label
    }()
    
    let datePlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Month..."
        label.sizeToFit()
        label.textColor = .lightGray
        
        return label
    }()
    
    let dayPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Day..."
        label.sizeToFit()
        label.textColor = .lightGray
        
        return label
    }()
    
    let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainColor()
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("Upload", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleUpload), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleUpload() {
//        guard let uid = Auth.auth().currentUser?.uid, let profileImage = plusPhotoButton.imageView?.image, let name = textView1.text, let location = textView2.text, let phone = textView3.text, let type = textView4.text, let des = desTextView.text else {return}
        guard let uid = Auth.auth().currentUser?.uid, let profileImage = plusPhotoButton.imageView?.image, let name = nameContainer.text, let time = timeContainer.text, let date = dateContainer.text, let day = dayContainer.text, let location = locationContainer.text, let city = cityContainer.text, let phone = phoneContainer.text, let type = typeContainer.text, let des = desTextView.text else {return}
        
        var values = ["uid": uid, "name": name,
                      "time": time, "month": date, "day": day, "city": city, "type": type, "location": location, "phone": phone, "eventUrl": "", "des": des]
        
        let storage = Storage.storage().reference().child("eventPhotos").child("\(name).jpg")
        guard let profileData = profileImage.jpegData(compressionQuality: 0.5) else {return}
        group.enter()
        storage.putData(profileData, metadata: nil) { (metadata, error) in
            if (error != nil) {
                print("Fail to upload to storage: ", error!)
                return
            }
            storage.downloadURL(completion: { (url, error) in
                if (error != nil) {
                    print("Fail to download url: ", error!)
                    return
                }
                if let imageUrl = url?.absoluteString {
                    values["eventUrl"] = imageUrl
                    self.group.leave()
                }
            })
        }
        
        group.notify(queue: .main) {
            Database.database().reference().child("posts").childByAutoId().updateChildValues(values, withCompletionBlock: { (error, ref) in
                if (error != nil) {
                    print("Fail to upload to database: ", error!)
                    return
                }
                print("Upload Successfully")
                if let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController {
                    mainTabBarController.selectedIndex = 0
                    mainTabBarController.setupViewController()
                }
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.mainColor()
        
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handlePlusPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let editImage = info[.editedImage] as? UIImage {
            plusPhotoButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let origialImage = info[.originalImage] as? UIImage{
            plusPhotoButton.setImage(origialImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        plusPhotoButton.layer.cornerRadius = 20
        plusPhotoButton.layer.masksToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(handleDismiss))
        if let titleName = name {
            self.navigationItem.title = titleName
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.mainColor()]
        }
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(plusPhotoButton)
        
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: view.frame.height / 4)
        
        let stackView = UIStackView(arrangedSubviews: [nameContainer, timeContainer, containerView1, containerView2, containerView3])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        view.addSubview(stackView)
        
        containerView1.addSubview(dateContainer)
        containerView1.addSubview(dayContainer)
        
        containerView2.addSubview(locationContainer)
        containerView2.addSubview(cityContainer)
        
        containerView3.addSubview(phoneContainer)
        containerView3.addSubview(typeContainer)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 184)
        
        nameContainer.delegate = self
        timeContainer.delegate = self
        locationContainer.delegate = self
        cityContainer.delegate = self
        dateContainer.delegate = self
        dayContainer.delegate = self
        phoneContainer.delegate = self
        typeContainer.delegate = self
        
        dateContainer.anchor(top: containerView1.topAnchor, left: containerView1.leftAnchor, bottom: containerView1.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 180, height: 0)
        dayContainer.anchor(top: containerView1.topAnchor, left: dateContainer.rightAnchor, bottom: containerView1.bottomAnchor, right: containerView1.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        locationContainer.anchor(top: containerView2.topAnchor, left: containerView2.leftAnchor, bottom: containerView2.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 180, height: 0)
        cityContainer.anchor(top: containerView2.topAnchor, left: locationContainer.rightAnchor, bottom: containerView2.bottomAnchor, right: containerView2.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        phoneContainer.anchor(top: containerView3.topAnchor, left: containerView3.leftAnchor, bottom: containerView3.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 180, height: 0)
        typeContainer.anchor(top: containerView3.topAnchor, left: phoneContainer.rightAnchor, bottom: containerView3.bottomAnchor, right: containerView3.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        nameContainer.addSubview(namePlaceholder)
        timeContainer.addSubview(timePlaceholder)
        dateContainer.addSubview(datePlaceholder)
        dayContainer.addSubview(dayPlaceholder)
        locationContainer.addSubview(placePlaceholder)
        cityContainer.addSubview(cityPlaceholder)
        phoneContainer.addSubview(phonePlaceholder)
        typeContainer.addSubview(typePlaceholder)
        
        namePlaceholder.font = UIFont.italicSystemFont(ofSize: (nameContainer.font?.pointSize)!)
        namePlaceholder.frame.origin = CGPoint(x: 5, y: (nameContainer.font?.pointSize)! / 2)
        namePlaceholder.isHidden = !nameContainer.text.isEmpty
        
        timePlaceholder.font = UIFont.italicSystemFont(ofSize: (timeContainer.font?.pointSize)!)
        timePlaceholder.frame.origin = CGPoint(x: 5, y: (timeContainer.font?.pointSize)! / 2)
        timePlaceholder.isHidden = !timeContainer.text.isEmpty
        
        datePlaceholder.font = UIFont.italicSystemFont(ofSize: (dateContainer.font?.pointSize)!)
        datePlaceholder.frame.origin = CGPoint(x: 5, y: (dateContainer.font?.pointSize)! / 2)
        datePlaceholder.isHidden = !dateContainer.text.isEmpty
        
        dayPlaceholder.font = UIFont.italicSystemFont(ofSize: (dayContainer.font?.pointSize)!)
        dayPlaceholder.frame.origin = CGPoint(x: 5, y: (dayContainer.font?.pointSize)! / 2)
        dayPlaceholder.isHidden = !dayContainer.text.isEmpty
        
        placePlaceholder.font = UIFont.italicSystemFont(ofSize: (locationContainer.font?.pointSize)!)
        placePlaceholder.frame.origin = CGPoint(x: 5, y: (locationContainer.font?.pointSize)! / 2)
        placePlaceholder.isHidden = !locationContainer.text.isEmpty
        
        cityPlaceholder.font = UIFont.italicSystemFont(ofSize: (cityContainer.font?.pointSize)!)
        cityPlaceholder.frame.origin = CGPoint(x: 5, y: (cityContainer.font?.pointSize)! / 2)
        cityPlaceholder.isHidden = !cityContainer.text.isEmpty
        
        phonePlaceholder.font = UIFont.italicSystemFont(ofSize: (phoneContainer.font?.pointSize)!)
        phonePlaceholder.frame.origin = CGPoint(x: 5, y: (phoneContainer.font?.pointSize)! / 2)
        phonePlaceholder.isHidden = !phoneContainer.text.isEmpty
        
        typePlaceholder.font = UIFont.italicSystemFont(ofSize: (typeContainer.font?.pointSize)!)
        typePlaceholder.frame.origin = CGPoint(x: 5, y: (typeContainer.font?.pointSize)! / 2)
        typePlaceholder.isHidden = !typeContainer.text.isEmpty
        
        view.addSubview(desTextView)
        desTextView.delegate = self
        
        desTextView.anchor(top: stackView.bottomAnchor, left: stackView.leftAnchor, bottom: nil, right: stackView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        desTextView.addSubview(desPlaceholder)
        
        desPlaceholder.font = UIFont.italicSystemFont(ofSize: (desTextView.font?.pointSize)!)
        desPlaceholder.frame.origin = CGPoint(x: 5, y: (desTextView.font?.pointSize)! / 2)
        desPlaceholder.isHidden = !desTextView.text.isEmpty
        
        view.addSubview(uploadButton)
        
        uploadButton.anchor(top: desTextView.bottomAnchor, left: desTextView.leftAnchor, bottom: nil, right: desTextView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        namePlaceholder.isHidden = !nameContainer.text.isEmpty
        timePlaceholder.isHidden = !timeContainer.text.isEmpty
        datePlaceholder.isHidden = !dateContainer.text.isEmpty
        dayPlaceholder.isHidden = !dayContainer.text.isEmpty
        placePlaceholder.isHidden = !locationContainer.text.isEmpty
        cityPlaceholder.isHidden = !cityContainer.text.isEmpty
        phonePlaceholder.isHidden = !phoneContainer.text.isEmpty
        typePlaceholder.isHidden = !typeContainer.text.isEmpty
        desPlaceholder.isHidden = !desTextView.text.isEmpty
    }
    
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
