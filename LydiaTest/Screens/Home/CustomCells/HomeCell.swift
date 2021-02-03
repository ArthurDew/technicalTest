//
//  HomeCell.swift
//  LydiaTest
//
//  Created by Arthur de Wurstemberger on 29/01/2021.
//

import UIKit

class HomeCell : UITableViewCell {
    
    var nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        addSubview(nameLabel)
        
        configNameLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(user: Result) {
        let fullName = user.name.first + " " + user.name.last

        nameLabel.text = fullName + " " + getFlag(from: user.nat)
    }
    
    func configNameLabel() {
        nameLabel.font = UIFont.init(name: "Futura-medium", size: 15)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: /*picture.*/leadingAnchor, constant: 20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func getFlag(from country: String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
    }
}
