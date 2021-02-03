//
//  HomeController.swift
//  LydiaTest
//
//  Created by Arthur de Wurstemberger on 29/01/2021.
//

import UIKit
import SystemConfiguration

class HomeController: UIViewController {
    let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    
    var homeView: HomeView!

    var users: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
        
        getUsers()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupView() {
        let mainView = HomeView(frame: self.view.frame)
        self.homeView = mainView
        self.homeView.delegate = self
        self.view.addSubview(homeView)
        homeView.backgroundColor = .white
        homeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        homeView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func getUsers() {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.reachability!, &flags)
        
        if isNetworkReachable(with: flags) {
            
            let requestUrl = "https://randomuser.me/api/?results=10"
            let url = URL(string: requestUrl)

            let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print("Error accessing API: /(error)")
                    self.getStoredData()
                    return
                }
                if let data = data {
                    do {
                        let results = try JSONDecoder().decode(Data.self, from: data)
                        DispatchQueue.main.async {
                            if self.users.count == 0 {
                                let defaults = UserDefaults.standard
                                defaults.set(String(data: data, encoding: String.Encoding.utf8), forKey: "search")
                            }

                            self.users += results.results
                            self.homeView.tableView.reloadData()
                        }
                    } catch let jsonError as NSError {
                        print(jsonError)
                        if self.users.count == 0 {
                            self.getStoredData()
                        }
                    }
                }
            })
            task.resume()
        } else if self.users.count == 0 {
            self.getStoredData()
        }
    }
    
    func getStoredData() {
        let defaults = UserDefaults.standard
        do {
            let localResult = defaults.string(forKey: "search")
            let results = try JSONDecoder().decode(Data.self, from: localResult!.data(using: .utf8)!)
            self.users = results.results
            DispatchQueue.main.async {
                self.homeView.tableView.reloadData()
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func seeProfile(user: Result) {
        let vc = ProfileController()
        vc.user = user
        present(vc, animated: true, completion: nil)
    }
    
    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        
        return isReachable && (!needsConnection || canConnectWithoutInteraction)
    }
}
