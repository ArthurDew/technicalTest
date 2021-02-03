//
//  HomeView.swift
//  LydiaTest
//
//  Created by Arthur de Wurstemberger on 29/01/2021.
//

import UIKit

class HomeView: UIView {
    weak var delegate: HomeController?
    
    var safeArea: UILayoutGuide!
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func setup(){
        self.backgroundColor = .white
        safeArea = self.layoutMarginsGuide
        
        self.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.rowHeight = 60
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeCell.self, forCellReuseIdentifier: "homeCell")
    }
    
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.delegate?.users.count)!
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        
        cell.set(user: (self.delegate?.users[indexPath.row])!)
        
        cell.selectionStyle = .default
        
        return cell
    }
}

extension HomeView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.seeProfile(user: (self.delegate?.users[indexPath.row])!)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (self.delegate?.users.count)! - 8) {
            self.delegate?.getUsers()
        }
    }
}
