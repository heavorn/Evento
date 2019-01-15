//
//  HomeHeader.swift
//  Evento
//
//  Created by Sovorn on 11/24/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

let layerAlpha: CGFloat = 0.6
let labelFontSize: CGFloat = 16

let font = "Courier"
let boldFont = "Courier-Bold"

class HomeHeader: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    
    lazy var locationButton: UIButton = {
        let button = UIButton(type: .system)
//        button.setTitle("Phnom Penh", for: .normal)
        button.titleLabel?.font = UIFont(name: boldFont, size: 18)
        button.tintColor = .black
        button.underLine()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleLocation), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleLocation() {
//        print("HAHA")
//        homeController?.fetchUserID()
//        print("LOL")
        homeController?.presentLocationController()
    }
    
    let browseLabel: UILabel = {
        let label = UILabel()
        label.text = "Browsing Categories"
        label.font = UIFont(name: boldFont, size: 15)
        
        return label
    }()
    
    let exploreTextView: UITextView = {
        let tv = UITextView()
        let attribute = NSMutableAttributedString(string: "Explore", attributes: [NSAttributedString.Key.font: UIFont(name: boldFont, size: 40)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        attribute.append(NSAttributedString(string: "\nSuggested events for you", attributes: [NSAttributedString.Key.font: UIFont(name: font, size: 12)!, NSAttributedString.Key.foregroundColor: UIColor.white]))
        tv.attributedText = attribute
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.isScrollEnabled = false
        
        return tv
    }()
    
    let headerBackground: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "homeBackground")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        
        return cv
    }()
    
    let layerView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: layerAlpha )
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let layerView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: layerAlpha )
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let layerView3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: layerAlpha )
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let layerView4: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: layerAlpha )
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let layerView5: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: layerAlpha )
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let layerView6: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: layerAlpha )
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var techImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "tech")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTech)))

        return iv
    }()
    
    @objc func handleTech() {
        UserDefaults.standard.set(techLabel.text, forKey: "type")
        self.homeController?.type = techLabel.text
        self.homeController?.fetchUserID()
        
    }

    
    let eduImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "edu")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    let busImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bus")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    let artImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "art")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    let musicImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "music")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    let sportImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "sport")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        
        return iv
    }()

    let techLabel: UILabel = {
        let label = UILabel()
        label.text = "Tech"
        label.textColor = .white
        label.font = UIFont(name: boldFont, size: labelFontSize)
        
        return label
    }()
    
    let eduLabel: UILabel = {
        let label = UILabel()
        label.text = "Edu"
        label.textColor = .white
        label.font = UIFont(name: boldFont, size: labelFontSize)
        
        return label
    }()
    
    let busLabel: UILabel = {
        let label = UILabel()
        label.text = "Bus"
        label.textColor = .white
        label.font = UIFont(name: boldFont, size: labelFontSize)
        
        return label
    }()
    
    let artLabel: UILabel = {
        let label = UILabel()
        label.text = "Art"
        label.textColor = .white
        label.font = UIFont(name: boldFont, size: labelFontSize)
        
        return label
    }()
    
    let musicLabel: UILabel = {
        let label = UILabel()
        label.text = "Music"
        label.textColor = .white
        label.font = UIFont(name: boldFont, size: labelFontSize)
        
        return label
    }()
    
    let sportLabel: UILabel = {
        let label = UILabel()
        label.text = "Sport"
        label.textColor = .white
        label.font = UIFont(name: boldFont, size: labelFontSize)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupBackgroundHeader()
        setupCollectionView()
        setupLabelBrowse()
        setupStackView()
        
//        self.locationButton.setTitle(homeController?.cityName, for: .normal)

    }
    
    private func setupBackgroundHeader(){
        
        addSubview(exploreTextView)
        
        self.insertSubview(headerBackground, at: 0)
        
        headerBackground.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerBackground.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
        exploreTextView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: (UIApplication.shared.statusBarView?.frame.height)! + 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 300, height: 80)
    }
    
    private func setupCollectionView(){
        addSubview(collectionView)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        collectionView.anchor(top: exploreTextView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: self.frame.height / 2)
        
        collectionView.register(HomeHeaderCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func setupLabelBrowse(){
        addSubview(browseLabel)
        addSubview(locationButton)
        
        browseLabel.anchor(top: collectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: self.frame.width * 0.5, height: 0)
        
        locationButton.anchor(top: collectionView.bottomAnchor, left: browseLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0    , width: 0, height: 0)
    }
    
    private func setupStackView() {
//        let stackView1 = UIStackView(arrangedSubviews: [techContainer, eduContainer, busContainer])
//        let stackView2 = UIStackView(arrangedSubviews: [artContainer, musicContainer, sportContainer])
        
        let stackView1 = UIStackView(arrangedSubviews: [techImageView, eduImageView, busImageView])
        let stackView2 = UIStackView(arrangedSubviews: [artImageView, musicImageView, sportImageView])
        let stackView = UIStackView(arrangedSubviews: [stackView1, stackView2])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView1.distribution = .fillEqually
        stackView1.axis = .horizontal
        stackView1.spacing = 10
        
        stackView2.distribution = .fillEqually
        stackView2.axis = .horizontal
        stackView2.spacing = 10
        
        addSubview(stackView)
        
        techImageView.addSubview(layerView1)
        eduImageView.addSubview(layerView2)
        busImageView.addSubview(layerView3)
        artImageView.addSubview(layerView4)
        musicImageView.addSubview(layerView5)
        sportImageView.addSubview(layerView6)
        
        techImageView.addSubview(techLabel)
        eduImageView.addSubview(eduLabel)
        busImageView.addSubview(busLabel)
        artImageView.addSubview(artLabel)
        musicImageView.addSubview(musicLabel)
        sportImageView.addSubview(sportLabel)
        
//        techContainer.addSubview(techImageView)
//        eduContainer.addSubview(eduImageView)
//        busContainer.addSubview(busImageView)
//        artContainer.addSubview(artImageView)
//        musicContainer.addSubview(musicImageView)
//        sportContainer.addSubview(sportImageView)
        
        stackView.anchor(top: collectionView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 45, paddingLeft: 30, paddingBottom: 25, paddingRight: 30, width: 0, height: 0)
        
        
        layerView1.anchor(top: techImageView.topAnchor, left: techImageView.leftAnchor, bottom: techImageView.bottomAnchor, right: techImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        layerView2.anchor(top: eduImageView.topAnchor, left: eduImageView.leftAnchor, bottom: eduImageView.bottomAnchor, right: eduImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        layerView3.anchor(top: busImageView.topAnchor, left: busImageView.leftAnchor, bottom: busImageView.bottomAnchor, right: busImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        layerView4.anchor(top: artImageView.topAnchor, left: artImageView.leftAnchor, bottom: artImageView.bottomAnchor, right: artImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        layerView5.anchor(top: musicImageView.topAnchor, left: musicImageView.leftAnchor, bottom: musicImageView.bottomAnchor, right: musicImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        layerView6.anchor(top: sportImageView.topAnchor, left: sportImageView.leftAnchor, bottom: sportImageView.bottomAnchor, right: sportImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        techLabel.anchor(top: nil, left: nil, bottom: techImageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 4, paddingRight: 0, width: 0, height: 0)
        techLabel.centerXAnchor.constraint(equalTo: techImageView.centerXAnchor).isActive = true
        
        eduLabel.anchor(top: nil, left: nil, bottom: eduImageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 4, paddingRight: 0, width: 0, height: 0)
        eduLabel.centerXAnchor.constraint(equalTo: eduImageView.centerXAnchor).isActive = true
        
        busLabel.anchor(top: nil, left: nil, bottom: busImageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 4, paddingRight: 0, width: 0, height: 0)
        busLabel.centerXAnchor.constraint(equalTo: busImageView.centerXAnchor).isActive = true
        
        artLabel.anchor(top: nil, left: nil, bottom: artImageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 4, paddingRight: 0, width: 0, height: 0)
        artLabel.centerXAnchor.constraint(equalTo: artImageView.centerXAnchor).isActive = true
        
        musicLabel.anchor(top: nil, left: nil, bottom: musicImageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 4, paddingRight: 0, width: 0, height: 0)
        musicLabel.centerXAnchor.constraint(equalTo: musicImageView.centerXAnchor).isActive = true
        
        sportLabel.anchor(top: nil, left: nil, bottom: sportImageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 4, paddingRight: 0, width: 0, height: 0)
        sportLabel.centerXAnchor.constraint(equalTo: sportImageView.centerXAnchor).isActive = true
        
//        techImageView.anchor(top: techContainer.topAnchor, left: techContainer.leftAnchor, bottom: techContainer.bottomAnchor, right: techContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        eduImageView.anchor(top: eduContainer.topAnchor, left: eduContainer.leftAnchor, bottom: eduContainer.bottomAnchor, right: eduContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        busImageView.anchor(top: busContainer.topAnchor, left: busContainer.leftAnchor, bottom: busContainer.bottomAnchor, right: busContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        artImageView.anchor(top: artContainer.topAnchor, left: artContainer.leftAnchor, bottom: artContainer.bottomAnchor, right: artContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        musicImageView.anchor(top: musicContainer.topAnchor, left: musicContainer.leftAnchor, bottom: musicContainer.bottomAnchor, right: musicContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        sportImageView.anchor(top: sportContainer.topAnchor, left: sportContainer.leftAnchor, bottom: sportContainer.bottomAnchor, right: sportContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeHeaderCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width * 1.8 / 3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//let techContainer: UIView = {
//    let view = UIView()
//    view.backgroundColor = .mainColor()
//    view.layer.cornerRadius = 10
//    view.clipsToBounds = true
//
//    return view
//}()
//
//let eduContainer: UIView = {
//    let view = UIView()
//    view.backgroundColor = .blue
//    view.layer.cornerRadius = 10
//    view.clipsToBounds = true
//
//    return view
//}()
//
//let busContainer: UIView = {
//    let view = UIView()
//    view.backgroundColor = .yellow
//    view.layer.cornerRadius = 10
//    view.clipsToBounds = true
//
//    return view
//}()
//
//let artContainer: UIView = {
//    let view = UIView()
//    view.backgroundColor = .lightGray
//    view.layer.cornerRadius = 10
//    view.clipsToBounds = true
//
//    return view
//}()
//
//let musicContainer: UIView = {
//    let view = UIView()
//    view.backgroundColor = .purple
//    view.layer.cornerRadius = 10
//    view.clipsToBounds = true
//
//    return view
//}()
//
//let sportContainer: UIView = {
//    let view = UIView()
//    view.backgroundColor = .green
//    view.layer.cornerRadius = 10
//    view.clipsToBounds = true
//
//    return view
//}()
