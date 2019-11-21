//
//  MainTabBarController.swift
//  FirebaseProject
//
//  Created by Anthony Gonzalez on 11/21/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    lazy var feedVC = UINavigationController(rootViewController: FeedViewController())
    
    lazy var profileVC = ProfileViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: nil, tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.square"), tag: 1)
        self.viewControllers = [feedVC, profileVC]
    }
    
    
    
}
