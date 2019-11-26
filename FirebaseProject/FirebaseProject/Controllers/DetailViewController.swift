//
//  DetailViewController.swift
//  FirebaseProject
//
//  Created by Anthony Gonzalez on 11/26/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iv)
        return iv
    }()
    
    
    var currentPost: Post!
    
    
    private func loadImage () {
        DispatchQueue.main.async {
            FirebaseStorageService.uploadManager.getImage(url: self.currentPost.imageUrl!) { (result) in
                switch result {
                    
                case .success(let imageFromFirebase):
                    self.imageView.image = imageFromFirebase
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    private func setConstraints(){
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 350),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        loadImage()
        
    }
}


