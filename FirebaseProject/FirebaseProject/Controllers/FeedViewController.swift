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
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cv)
        cv.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "postCell")
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .green
        return cv
    }()
    
    var posts = [Post]() {
        didSet {
            
        }
    }
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

extension FeedViewController {
    private func setConstraints() {
        
    }
    
    private func setCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
}

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCollectionViewCell
        let imageData = posts[indexPath.row]
        
        DispatchQueue.main.async {
            FirebaseStorageService.uploadManager.getImage(url: imageData.imageUrl!) { (result) in
                switch result {
                    
                case .success(let imageFromFirebase):
                    cell.imageView.image = imageFromFirebase
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        return cell
    }
    
    
}
