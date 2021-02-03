//
//  ProfileInfoView.swift
//  LydiaTest
//
//  Created by Arthur de Wurstemberger on 30/01/2021.
//

import UIKit
import MapKit

class ProfileInfoView: UIView {
    var user : Result!
    
    let mainView = UIView()
    let infoView = UIScrollView()
    
    let emailTitleLabel = UILabel()
    let emailLabel = UILabel()
    
    let phoneTitleLabel = UILabel()
    let phoneLabel = UILabel()
    
    let cellTitleLabel = UILabel()
    let cellLabel = UILabel()
    
    let birthdayTitleLabel = UILabel()
    let birthdayLabel = UILabel()
    
    let addressTitleLabel = UILabel()
    let addressLabel = UILabel()
    let countryLabel = UILabel()
    
    let mapView = MKMapView()
    
    init(frame: CGRect, user: Result) {
        super.init(frame: frame)
        self.user = user
        setup()
        configInfoView()
        configEmail()
        configPhone()
        configCell()
        configBirthday()
        configAddress()
        configMap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func setup() {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        self.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        mainView.addSubview(infoView)
        
        infoView.addSubview(emailTitleLabel)
        infoView.addSubview(emailLabel)
        infoView.addSubview(phoneTitleLabel)
        infoView.addSubview(phoneLabel)
        infoView.addSubview(cellTitleLabel)
        infoView.addSubview(cellLabel)
        infoView.addSubview(birthdayTitleLabel)
        infoView.addSubview(birthdayLabel)
        infoView.addSubview(addressTitleLabel)
        infoView.addSubview(addressLabel)
        infoView.addSubview(countryLabel)
        infoView.addSubview(mapView)
    }
    
    func configInfoView() {
        infoView.backgroundColor = .white
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.topAnchor.constraint(equalTo: topAnchor, constant: 125).isActive = true
        infoView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        infoView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        infoView.layer.cornerRadius = 20
    }
    
    func configEmail() {
        emailTitleLabel.text = "Email :"
        emailTitleLabel.font = UIFont.init(name: "Futura-mediumItalic", size: 15)
        emailTitleLabel.textColor = .darkGray
        emailTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 270).isActive = true
        emailTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        emailLabel.text = user.email
        emailLabel.font = UIFont.init(name: "Futura-medium", size: 15)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.centerYAnchor.constraint(equalTo: emailTitleLabel.centerYAnchor).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func configPhone() {
        phoneTitleLabel.text = "Phone :"
        phoneTitleLabel.font = UIFont.init(name: "Futura-mediumItalic", size: 15)
        phoneTitleLabel.textColor = .darkGray
        phoneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneTitleLabel.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor, constant: 15).isActive = true
        phoneTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        phoneLabel.text = user.phone
        phoneLabel.font = UIFont.init(name: "Futura-medium", size: 15)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.centerYAnchor.constraint(equalTo: phoneTitleLabel.centerYAnchor).isActive = true
        phoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func configCell() {
        cellTitleLabel.text = "Cell :"
        cellTitleLabel.font = UIFont.init(name: "Futura-mediumItalic", size: 15)
        cellTitleLabel.textColor = .darkGray
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cellTitleLabel.topAnchor.constraint(equalTo: phoneTitleLabel.bottomAnchor, constant: 15).isActive = true
        cellTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        cellLabel.text = user.cell
        cellLabel.font = UIFont.init(name: "Futura-medium", size: 15)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.centerYAnchor.constraint(equalTo: cellTitleLabel.centerYAnchor).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func configBirthday() {
        birthdayTitleLabel.text = "Birthday :"
        birthdayTitleLabel.font = UIFont.init(name: "Futura-mediumItalic", size: 15)
        birthdayTitleLabel.textColor = .darkGray
        birthdayTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdayTitleLabel.topAnchor.constraint(equalTo: cellTitleLabel.bottomAnchor, constant: 15).isActive = true
        birthdayTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        let index = user.dob.date.index(user.dob.date.startIndex, offsetBy: 10)
        let mySubstring = user.dob.date.prefix(upTo: index)
        if let date = dateFormatterGet.date(from: String(mySubstring)) {
            birthdayLabel.text = dateFormatterPrint.string(from: date) + " (" + "\(user.dob.age)" + " years)"
        } else {
            birthdayLabel.text = user.dob.date + " (" + "\(user.dob.age)" + " years)"
            print("There was an error decoding the string")
        }
        birthdayLabel.font = UIFont.init(name: "Futura-medium", size: 15)
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdayLabel.centerYAnchor.constraint(equalTo: birthdayTitleLabel.centerYAnchor).isActive = true
        birthdayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func configAddress() {
        addressTitleLabel.text = "Address :"
        addressTitleLabel.font = UIFont.init(name: "Futura-mediumItalic", size: 15)
        addressTitleLabel.textColor = .darkGray
        addressTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addressTitleLabel.topAnchor.constraint(equalTo: birthdayTitleLabel.bottomAnchor, constant: 15).isActive = true
        addressTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        addressLabel.text = "\(user.location.street.number)" + " " + user.location.street.name + ", " + user.location.city
        addressLabel.font = UIFont.init(name: "Futura-medium", size: 15)
        addressLabel.textAlignment = .right
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.centerYAnchor.constraint(equalTo: addressTitleLabel.centerYAnchor).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        addressLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        countryLabel.text = user.location.state + ", " + user.location.country
        countryLabel.font = UIFont.init(name: "Futura-medium", size: 15)
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10).isActive = true
        countryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func configMap() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 15).isActive = true
        mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isUserInteractionEnabled = true
        
        //Region
        let address = user.location.city + " " + user.location.country
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                return
            }
            let noLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let viewRegion = MKCoordinateRegion(center: noLocation, latitudinalMeters: 500, longitudinalMeters: 500)
            self.mapView.setRegion(viewRegion, animated: false)
            
            //Annotation
            let CLLCoordType = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let anno = MKPointAnnotation()
            anno.coordinate = CLLCoordType
            self.mapView.addAnnotation(anno)
            
            self.mapView.layoutIfNeeded()
        }
        
        
    }
}
