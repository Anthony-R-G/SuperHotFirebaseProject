//
//  ProfileViewController.swift
//  FirebaseProject
//
//  Created by Anthony Gonzalez on 11/21/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase


class ProfileViewController: UIViewController {

    lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        return button
    }()
    
    

    @objc func signOutButtonPressed() {
          FirebaseAuthService.manager.signOutUser()
          
          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window else {return}
          
          window.rootViewController = LoginViewController()
      }
    
    private func setConstraints() {
        [signOutButton].forEach{view.addSubview($0)}
        [signOutButton].forEach{$0.translatesAutoresizingMaskIntoConstraints = false }
        
        setSignoutButtonConstraints()
    }
    private func setSignoutButtonConstraints() {
         signOutButton.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
             signOutButton.widthAnchor.constraint(equalToConstant: 100),
             signOutButton.heightAnchor.constraint(equalToConstant: 40)
         ])
     }
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        
        
    
 
    }
  
}
