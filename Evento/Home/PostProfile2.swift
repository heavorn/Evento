//
//  PostProfile.swift
//  Evento
//
//  Created by Sovorn on 12/7/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class PostProfile2: UIViewController {
    
    var post: Post?
    {
        didSet{
            guard let imageUrl = post?.eventUrl else {return}

            postImage.loadImage(urlString: imageUrl)
        }
    }
    
    lazy var postImage: CustomImageView = {
        let ci = CustomImageView()
        ci.clipsToBounds = true
        ci.contentMode = .scaleAspectFill
//        ci.backgroundColor = UIColor(white: 1, alpha: 0.8)
        ci.isUserInteractionEnabled = true
        ci.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapImage)))
        
        
        return ci
    }()
    
    @objc func handleTapImage() {
        print("Tap")
    }
    
    let blackView = UIView()
    
    var topConstrain: NSLayoutConstraint?
    
    let scrollView: UIScrollView = {
//        let sv = UIScrollView(frame: .zero)
        let sv = UIScrollView()
        sv.backgroundColor = .white
        sv.layer.cornerRadius = 15
        sv.layer.masksToBounds = true
//        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    @objc func handleMore(){
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(scrollView)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            let y = window.frame.height
            let height: CGFloat = y - 100
            
            scrollView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.scrollView.frame = CGRect(x: 0, y: y - height, width: window.frame.width, height: height)
                self.scrollView.contentSize = CGSize(width: window.frame.width, height: 2000)
                self.scrollView.showsVerticalScrollIndicator = false
                self.scrollView.addSubview(self.postImage)
                
                self.postImage.anchor(top: self.scrollView.topAnchor, left: self.scrollView.leftAnchor, bottom: nil, right: self.scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: window.frame.width, height: 200)
                
            }, completion: nil)
            
        }
    }
    
    @objc func handleDismiss(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.scrollView.frame = CGRect(x: 0, y: window.frame.height, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}

//import UIKit
//
//class PostProfile: UICollectionViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        collectionView.backgroundColor = .mainColor()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//
//        navigationController?.isNavigationBarHidden = false
//    }
//}










































