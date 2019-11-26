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

    var user: AppUser!
    var userTest = Auth.auth().currentUser
    var isCurrentUser = false
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let db = Firestore.firestore()
        let documentPath = userTest?.uid
        let docRef = db.collection("users").document(documentPath!)
        print(docRef)
        
 
    }
  
}
