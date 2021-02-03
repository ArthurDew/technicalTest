//
//  ProfileController.swift
//  LydiaTest
//
//  Created by Arthur de Wurstemberger on 29/01/2021.
//

import UIKit

class ProfileController: UIViewController {
    var user : Result!
    var test = 1
    
    var profileView: ProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupView() {
        let mainView = ProfileView(frame: self.view.frame, user: self.user)
        self.profileView = mainView
        self.profileView.delegate = self
        self.view.addSubview(profileView)
        profileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        profileView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func closeProfile() {
        dismiss(animated: true, completion: nil)
    }
}
