//
//  SignUpViewController.swift
//  FirebaseProject
//
//  Created by Anthony Gonzalez on 11/21/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.9101040959, green: 0.9046940207, blue: 0.9142627716, alpha: 1)
        textField.delegate = self
        return textField
    }()
    
    lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.9101040959, green: 0.9046940207, blue: 0.9142627716, alpha: 1)
        textField.delegate = self
        return textField
    }()
    
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.9101040959, green: 0.9046940207, blue: 0.9142627716, alpha: 1)
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.9101040959, green: 0.9046940207, blue: 0.9142627716, alpha: 1)
        textField.delegate = self
        return textField
    }()
    
    lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private func showAlert(message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message as a string.
    private func validateFields() -> String? {
        //Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showAlert(message: "Please fill in all required fields")
        }
        
        //Check if password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            showAlert(message: "Please make sure your password is at least 8 characters, contains a special character, and a number")
        }
        return nil
    }
    
    @objc private func signUpButtonPressed() {
        //Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            //There's something wrong with the fields. Show error message.
            showAlert(message: error!)
        } else {
            //Create cleaned versions of the data.
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //Check for errors
                if err != nil {
                    self.showAlert(message: "Error creating user")
                    
                } else {
                    //User was created successfully. Now store the first and last name.
                    let db = Firestore.firestore() //Reference to firestore object where we can use all methods to add data to database.
                    
                    
                    //Since the collection online is called "users", we want to add a document to it. The document will be the user's info.
                    db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            //Show error message
                            self.showAlert(message: "Error saving user data")
                            //User was already created and can be logged into with email/password. However, first/last names couldn't be saved to document
                        }
                    }
                      //Transition to home screen
                    let mainVC = MainTabBarController()
                    self.view.window?.rootViewController = mainVC
                    self.view.window?.makeKeyAndVisible()
                }
            }
          
        }
        
    }
    
    func transitionToHome() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        
    }
}

extension SignUpViewController {
    
    private func setConstraints() {
        [nameStackView, emailTextField, passwordTextField, signUpButton].forEach({view.addSubview($0)})
        [nameStackView, emailTextField, passwordTextField, signUpButton].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        setNameStackConstraints()
        setEmailTextFieldConstraints()
        setPasswordTextFieldConstraints()
        setSignUpButtonConstraints()
    }
    
    private func setNameStackConstraints() {
        NSLayoutConstraint.activate([
            nameStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            nameStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            nameStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setEmailTextFieldConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 50),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    private func setPasswordTextFieldConstraints() {
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setSignUpButtonConstraints() {
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60),
            signUpButton.widthAnchor.constraint(equalToConstant: 80),
            signUpButton.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
}



extension SignUpViewController: UITextFieldDelegate {
    
}
