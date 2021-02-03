//
//  ProfileView.swift
//  LydiaTest
//
//  Created by Arthur de Wurstemberger on 29/01/2021.
//

import UIKit

class ProfileView: UIView {
    weak var delegate: ProfileController?
    var user : Result!
    
    let mainView = UIView()
    let closeButton = UIButton()
    let profilePicture = UIImageView()
    let nameLabel = UILabel()
    var profileInfoView : ProfileInfoView!
    
    init(frame: CGRect, user: Result) {
        super.init(frame: frame)
        self.user = user
        setup()
        configButton()
        configPicture()
        configLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func setup() {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        self.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        let infoView = ProfileInfoView(frame: self.frame, user: self.user)
        self.profileInfoView = infoView
        self.addSubview(profileInfoView)
        
        mainView.addSubview(closeButton)
        mainView.addSubview(profilePicture)
        mainView.addSubview(nameLabel)
        
        self.sendSubviewToBack(profileInfoView)
    }
    
    func configButton() {
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        closeButton.backgroundColor = .white
        closeButton.layer.cornerRadius = 25
        closeButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    @objc func buttonAction() {
        self.delegate?.closeProfile()
    }
    
    func configPicture() {
        let url = URL(string: user.picture.large)

        if let data = try? Foundation.Data(contentsOf: url!) {
            profilePicture.image = UIImage(data: data)!
        } else {
            profilePicture.image = #imageLiteral(resourceName: "blank-profile-picture")
        }
        
        profilePicture.layer.cornerRadius = 75
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderWidth = 6
        profilePicture.layer.borderColor = UIColor.white.cgColor
        
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profilePicture.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        profilePicture.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func configLabel() {
        nameLabel.text = user.name.title + " " + user.name.first + " " + user.name.last
        nameLabel.font = UIFont.init(name: "Futura-medium", size: 25)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 10).isActive = true
    }
}
