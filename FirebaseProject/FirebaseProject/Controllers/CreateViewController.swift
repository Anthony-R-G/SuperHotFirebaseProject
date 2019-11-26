//
//  CreateViewController.swift
//  FirebaseProject
//
//  Created by Anthony Gonzalez on 11/25/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import Kingfisher
import Photos

class CreateViewController: UIViewController {
    
    //MARK: -- Lazy Properties
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        iv.addGestureRecognizer(gesture)
        view.addSubview(iv)
        return iv
    }()
    
    lazy var uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(uploadButtonPressed), for: .touchUpInside)
        view.addSubview(button)
        
        return button
    }()
    
    
    var imageURL: String? = nil
    
    //MARK: -- Methods
    
    @objc private func imageTapped() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined, .denied, .restricted:
            PHPhotoLibrary.requestAuthorization({[weak self] status in
                switch status {
                case .authorized:
                    self?.presentPhotoPickerController()
                case .denied:
                    print("Denied photo library permissions")
                default:
                    print("No usable status")
                }
            })
        default:
            presentPhotoPickerController()
        }
    }
    
     @objc private func uploadButtonPressed() {
           guard let user = FirebaseAuthService.manager.currentUser else {return}
           guard let photoUrl = imageURL else {return}
        FirestoreService.manager.createPost(post: Post(creatorID: user.uid, dateCreated: Date(), imageUrl: photoUrl)) { (result) in
               switch result {
               case .failure(let error):
                self.showAlert(message: "\(error)")
               case .success:
                   self.showAlert(message: "Posted")
               }
           }
       }
    
    
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func presentPhotoPickerController() {
        DispatchQueue.main.async{
            let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.delegate = self
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.allowsEditing = true
            imagePickerViewController.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePickerViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        view.backgroundColor = .white
    }
}

//MARK: -- Constraints
extension CreateViewController {
    private func setConstraints() {
        setImageViewConstraints()
        setUploadButtonConstraints()
    }
    
    private func setImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setUploadButtonConstraints() {
        NSLayoutConstraint.activate([
            uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60),
            uploadButton.heightAnchor.constraint(equalToConstant: 40),
            uploadButton.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
}

extension CreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            showAlert(message: "Couldn't get image")
            return
        }
        self.imageView.image = image
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        FirebaseStorageService.uploadManager.storeImage(image: imageData, completion: { [weak self] (result) in
            switch result{
            case .success(let url):
                self?.imageURL = url
                
            case .failure(let error):
                print(error)
            }
        })
        dismiss(animated: true, completion: nil)
    }
}








