//
//  PostCollectionViewCell.swift
//  FirebaseProject
//
//  Created by Anthony Gonzalez on 11/26/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
       let iv = UIImageView()
        addSubview(iv)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
 
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor)
            
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
