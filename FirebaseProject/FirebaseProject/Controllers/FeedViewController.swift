//
//  FeedViewController.swift
//  FirebaseProject
//
//  Created by Anthony Gonzalez on 11/21/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        return button
    }()
    
    @objc private func addButtonPressed () {
        let createVC = CreateViewController()
        createVC.navigationItem.title = "Upload Image"
        navigationController?.pushViewController(createVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = addButton
    }
}
