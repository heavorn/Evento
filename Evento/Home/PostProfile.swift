//
//  PostProfile.swift
//  Evento
//
//  Created by Sovorn on 12/12/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

class PostProfile: UIViewController {
    
    var post: Post?
    {
        didSet{
            guard let imageUrl = post?.eventUrl, let name = post?.name, let des = post?.des, let time = post?.time, let location = post?.location, let city = post?.city else {return}
            
            postImage.loadImage(urlString: imageUrl)
            titleLabel.text = name
            descriptionTextView.text = des
            
            let attribute1 = NSMutableAttributedString(string: "Date", attributes: [NSAttributedString.Key.font: UIFont(name: font, size: 16)!])
            
            attribute1.append(NSMutableAttributedString(string: "\n\(time)", attributes: [NSAttributedString.Key.font: UIFont(name: font, size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            dateTextView.attributedText = attribute1
            
            let attribute2 = NSMutableAttributedString(string: "Location", attributes: [NSAttributedString.Key.font: UIFont(name: font, size: 16)!])
            
            attribute2.append(NSMutableAttributedString(string: "\n\(location), \(city)", attributes: [NSAttributedString.Key.font: UIFont(name: font, size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            
            locationTextView.attributedText = attribute2
            
        }
    }
    
    let confirmLabel: UILabel = {
        let label = UILabel()
        label.text = "CONFIRM BOOKING"
        label.textColor = .mainColor()
        label.font = UIFont(name: boldFont, size: 20)
        
        return label
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = .mainColor()
//        button.layer.borderColor = UIColor.mainColor().cgColor
//        button.layer.borderWidth = 1
        button.setTitle("Cancel", for: .normal)
//        button.setTitleColor(.mainColor(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleCancel() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView2.alpha = 0
            self.confirmContainer.isHidden = true
        })
    }
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = .mainColor()
//        button.layer.borderColor = UIColor.mainColor().cgColor
//        button.layer.borderWidth = 1
        button.setTitle("Confirm", for: .normal)
//        button.setTitleColor(.mainColor(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleConfirm), for: .touchUpInside)
        
        return button
    }()
    
    func postRequest(url: String, para: [String: String], completion: @escaping ([String: Any]?, Error?) -> Void) {
        // Send HTTP GET Request
        
        // Define server side script URL
        let scriptUrl = "\(url)/"
//
//        let name = "Kimly"
//        let email = "ktry@zamanuniversity.edu.kh"
        // Add one parameter
        let urlWithParams = scriptUrl + "?eventName=\(para["eventName"]!)&number=\(para["number"]!)&userName=\(para["userName"]!)&mailTo=\(para["mailTo"]!)"
        
//        let urlWithParams = scriptUrl + "?eventName=\(para["eventName"]!)&number=\(para["number"]!)&userName=\(name)&mailTo=\(email)"
        
        // Create NSURL Ibject
        guard let myUrl = URL(string: urlWithParams) else {return}
        
        let request = NSMutableURLRequest(url: myUrl)
        
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = "GET"
        
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil
            {
                print("error=\(error!)")
                return
            }
            
            print("Mail Sent!")
            // Print out response string
//            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print("responseString = \(responseString!)")
//
//
//            // Convert server json response to NSDictionary
//            do {
//                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
//
//                    // Print out dictionary
//                    print(convertedJsonIntoDict)
//
//                    // Get value by key
//                    let firstNameValue = convertedJsonIntoDict["eventName"] as? String
//                    print(firstNameValue!)
//
//                }
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
        }
        
        task.resume()
    }
    
    @objc func handleConfirm() {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//
//
//        })
        
        guard let uid = Auth.auth().currentUser?.uid, let organizer = post?.userId, let postName = post?.name, let email = currentUser?.email, let id = post?.id else {return}
        
        let ref = Database.database().reference()
        let value = [post?.id: 1]
        ref.child("books").child(uid).updateChildValues(value) { (error, ref) in
            if (error != nil){
                print("Failed to follow user:", error!)
                return
            }
            
            print("Successfully booked")
        }
        
        // prepare json data
        let parameters: [String: String] = ["mailTo": email, "eventName": postName, "number": id, "userName": (currentUser?.name)!]
        
        postRequest(url: "https://us-central1-evento-1dd01.cloudfunctions.net/sendMail", para: parameters) { ([String : Any]?, error) in
            if (error != nil){
                print("Failed to request:", error!)
                return
            }

            print("Successfully sent.")
        }
        
        
        let value2 = [uid: Date().timeIntervalSince1970] as [String : Any]
    ref.child("organizers").child(organizer).child(postName).updateChildValues(value2) { (error, ref) in
            if (error != nil){
                print("Failed to follow user:", error!)
                return
            }
        
            print("Successfully update organizer table.")
        }
        
        if let window = UIApplication.shared.keyWindow {
            self.confirmContainer.isHidden = true
            
            
            DispatchQueue.main.async {
                let label = UILabel()
//                label.text = "ការកក់រួចរាល់"
                label.text = "Thank You"
                label.textColor = .mainColor()
                label.font = UIFont(name: boldFont, size: 20)
                label.numberOfLines = 0
                label.backgroundColor = .white
                label.layer.cornerRadius = 10
                label.layer.masksToBounds = true
                label.textAlignment = .center
                label.frame = CGRect(x: 0, y: 0, width: 160, height: 80)
                label.center = self.blackView2.center
                window.addSubview(label)
                
                label.layer.transform = CATransform3DMakeScale(0, 0, 0)
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    label.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }, completion: { (completed) in
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        label.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                        label.alpha = 0
                        self.blackView2.alpha = 0
                    }, completion: { (_) in
                        label.removeFromSuperview()
                        self.handleDismiss()
                    })
                })
                
            }
        }
    }
    
//    func configuredMailComposeViewController() -> MFMailComposeViewController {
//        let mailComposerVC = MFMailComposeViewController()
//        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
//
//        mailComposerVC.setToRecipients(["vornvalentine@gmail.com"])
//        mailComposerVC.setSubject("Sending you an in-app e-mail...")
//        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
//
//        return mailComposerVC
//    }
//
//    func showSendMailErrorAlert() {
//        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
//        sendMailErrorAlert.show()
//    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true, completion: nil)
//    }

    lazy var bookButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainColor()
        button.setTitle("Request", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleBook() {
        if let window = UIApplication.shared.keyWindow {
            blackView2.backgroundColor = UIColor(white: 0, alpha: 0.65)
            
            window.addSubview(blackView2)
            //            window.addSubview(scrollView)
            window.addSubview(confirmContainer)
//            confirmContainer.isHidden = false
            
            blackView2.frame = window.frame
            blackView2.alpha = 0
            
            confirmContainer.addSubview(confirmLabel)
            confirmContainer.addSubview(cancelButton)
            confirmContainer.addSubview(confirmButton)
            
//            confirmContainer.frame = CGRect(x: window.frame.width / 2 - 150, y: window.frame.height, width: 300, height: 160)
            confirmContainer.frame = CGRect(x: window.frame.width / 2 - 150, y: window.frame.height / 2 - 80, width: 300, height: 160)
            confirmContainer.isHidden = true
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView2.alpha = 1
//                self.confirmContainer.frame = CGRect(x: window.frame.width / 2 - 150, y: window.frame.height / 2 - 80, width: 300, height: 160)
                self.confirmContainer.isHidden = false
                
                self.confirmLabel.anchor(top: self.confirmContainer.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
                self.confirmLabel.centerXAnchor.constraint(equalTo: self.confirmContainer.centerXAnchor).isActive = true
                
                self.cancelButton.anchor(top: nil, left: self.confirmContainer.leftAnchor, bottom: self.confirmContainer.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 6, paddingRight: 0, width: 141, height: 50)
                
                self.confirmButton.anchor(top: nil, left: nil, bottom: self.confirmContainer.bottomAnchor, right: self.confirmContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 6, paddingRight: 6, width: 141, height: 50)
                
            }, completion: nil)
            
        }
    }
    
    let confirmContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let zamanImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "zaman")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        
        return iv
    }()
    
    let dateTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.isScrollEnabled = false
        
        return tv
    }()
    
    let locationTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.isScrollEnabled = false
        
        return tv
    }()
    
    let dateImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "manage")
        iv.clipsToBounds = true
        iv.image = iv.image?.imageWithColor(color1: .lightGray)
        
        return iv
    }()
    
    let locationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "place")
        iv.clipsToBounds = true
        iv.image = iv.image?.imageWithColor(color1: .lightGray)
        
        return iv
    }()
    
    let innerContainer3: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let innerContainer4: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let descriptionTextView: UILabel = {
        let tf = UILabel()
        tf.backgroundColor = .clear
        tf.numberOfLines = 0
        tf.font = UIFont(name: font, size: 16)
        
        return tf
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.textColor = .black
        label.font = UIFont(name: boldFont, size: 38)
        
        return label
    }()
    
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
    
    let container3: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    
    lazy var postImage: CustomImageView = {
        let ci = CustomImageView()
        ci.clipsToBounds = true
        ci.contentMode = .scaleAspectFill
        //        ci.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        
        return ci
    }()
    
    let blackView = UIView()
    var blackView2 = UIView()
    
    var topConstrain: NSLayoutConstraint?
    
    var height: CGFloat?
    
    let heightConstant: CGFloat = 100
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleContainerView)))
        
        return view
    }()
    
    @objc func handleContainerView(recognizer: UIPanGestureRecognizer) {
        let height = (self.containerView.frame.height / 2) + 100
        switch recognizer.state {
        case .began:
            ()
        case .changed:
            recognizer.view?.center.y = (recognizer.view?.center.y)! + recognizer.translation(in: view).y < height ? (recognizer.view?.center.y)! : (recognizer.view?.center.y)! + recognizer.translation(in: view).y
            recognizer.setTranslation(CGPoint.zero, in: view)
        case .ended:
            if (recognizer.view?.center.y)! >= self.containerView.frame.height {
                self.handleDismiss()
            } else {
                self.handleBackToTop()
            }
        default:
            break
        }
    }
    
    let scrollView: UIScrollView = {
        //        let sv = UIScrollView(frame: .zero)
        let sv = UIScrollView()
        sv.backgroundColor = .white
        sv.layer.cornerRadius = 15
        sv.layer.masksToBounds = true
        //        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    func checkIfEventIsBooked() {
        guard let uid = Auth.auth().currentUser?.uid, let postId = post?.id else {return}
        
    Database.database().reference().child("books").child(uid).child(postId).observeSingleEvent(of: .value) { (snapshot) in
            if let isBooked = snapshot.value as? Int, isBooked == 1 {
                self.bookButton.backgroundColor = .blurColor()
                self.bookButton.isEnabled = false
            } else {
                self.bookButton.backgroundColor = .mainColor()
                self.bookButton.isEnabled = true
            }
        }
    }
    
    @objc func handleMore(){
        
        checkIfEventIsBooked()
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
//            window.addSubview(scrollView)
            window.addSubview(containerView)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            let y = window.frame.height
            
            containerView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: y - heightConstant)
            
            let stackView = UIStackView(arrangedSubviews: [container1, container2, container3])
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 0
            
            let innerStack = UIStackView(arrangedSubviews: [titleLabel, descriptionTextView, innerContainer3, innerContainer4])
            innerStack.axis = .vertical
            innerStack.distribution = .fillEqually
            innerStack.spacing = 0
            
            container2.addSubview(innerStack)
            container3.addSubview(zamanImageView)
            container3.addSubview(bookButton)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.containerView.frame = CGRect(x: 0, y: self.heightConstant, width: window.frame.width, height: y - self.heightConstant)
                self.containerView.addSubview(stackView)
                
                stackView.anchor(top: self.containerView.topAnchor, left: self.containerView.leftAnchor, bottom: self.containerView.bottomAnchor, right: self.containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
                
                self.container1.addSubview(self.postImage)
                
                self.postImage.anchor(top: self.container1.topAnchor, left: self.container1.leftAnchor, bottom: self.container1.bottomAnchor, right: self.container1.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
                
                innerStack.anchor(top: self.container2.topAnchor, left: self.container2.leftAnchor, bottom: self.container2.bottomAnchor, right: self.container2.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
                
                self.innerContainer3.addSubview(self.dateImageView)
                self.innerContainer3.addSubview(self.dateTextView)
                
                self.innerContainer4.addSubview(self.locationImageView)
                self.innerContainer4.addSubview(self.locationTextView)
                
                self.dateImageView.anchor(top: self.innerContainer3.topAnchor, left: self.innerContainer3.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
//                self.dateImageView.centerYAnchor.constraint(equalTo: self.innerContainer3.centerYAnchor).isActive = true
                self.dateTextView.anchor(top: self.innerContainer3.topAnchor, left: self.dateImageView.rightAnchor, bottom: nil, right: self.innerContainer3.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
                
                self.locationImageView.anchor(top: self.innerContainer4.topAnchor, left: self.innerContainer4.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
                
                self.locationTextView.anchor(top: self.innerContainer4.topAnchor, left: self.locationImageView.rightAnchor, bottom: nil, right: self.innerContainer4.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
                
                self.zamanImageView.anchor(top: self.container3.topAnchor, left: self.container3.leftAnchor, bottom: self.containerView.safeAreaLayoutGuide.bottomAnchor, right: self.container3.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 50, paddingRight: 32, width: 0, height: 0)
                
                self.bookButton.anchor(top: self.zamanImageView.bottomAnchor, left: self.zamanImageView.leftAnchor, bottom: self.containerView.safeAreaLayoutGuide.bottomAnchor, right: self.zamanImageView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 0, height: 40)
                
                
            }, completion: nil)
            
        }
    }
    
    func handleBackToTop(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.containerView.frame = CGRect(x: 0, y: self.heightConstant, width: self.containerView.frame.width, height: self.containerView.frame.height)
        })
    }
    
    @objc func handleDismiss(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

