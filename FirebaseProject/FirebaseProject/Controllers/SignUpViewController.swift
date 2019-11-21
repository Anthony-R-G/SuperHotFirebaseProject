//
//  SignUpViewController.swift
//  FirebaseProject
//
//  Created by Anthony Gonzalez on 11/21/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

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
    
    
    @objc private func signUpButtonPressed() {
        
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
