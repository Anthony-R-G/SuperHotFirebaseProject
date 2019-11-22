//
//  ViewController.swift
//  FirebaseProject
//
//  Created by Anthony Gonzalez on 11/21/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: -- Lazy Properties
    lazy var emailNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email..."
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.9101040959, green: 0.9046940207, blue: 0.9142627716, alpha: 1)
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password..."
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.9101040959, green: 0.9046940207, blue: 0.9142627716, alpha: 1)
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don't have an account? Sign up", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Apple")
        return imageView
    }()
    
    //MARK: -- Methods
    
    private func showAlert(message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtonPressed() {
        //Validate text fields
        if emailNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.showAlert(message: "Please fill in all fields")
        } else {
            //Create cleaned versions of email and password textfields.
            let email = emailNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.showAlert(message: error!.localizedDescription)
                } else {
                    let mainVC = MainTabBarController()
                    self.view.window?.rootViewController = mainVC
                    self.view.window?.makeKeyAndVisible()
                }
                
            }
        }
    }
    
    @objc private func signUpButtonPressed() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        view.backgroundColor = .white
    }
}

//MARK: -- Constraints
extension LoginViewController {
    
    private func setConstraints() {
        [emailNameTextField, passwordTextField, loginButton, signUpButton, logoImageView].forEach({view.addSubview($0)})
        
        [emailNameTextField, passwordTextField, loginButton, signUpButton, logoImageView].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        configureImageConstraints()
        configureTextFieldConstraints()
        configureSignUpButtonConstraints()
        configureLoginButtonConstraints()
    }
    
    
    private func configureLoginButtonConstraints() {
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170),
            loginButton.widthAnchor.constraint(equalToConstant: 350),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureSignUpButtonConstraints() {
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 70),
            signUpButton.widthAnchor.constraint(equalToConstant: 350),
            signUpButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureTextFieldConstraints() {
        NSLayoutConstraint.activate([
            emailNameTextField.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            emailNameTextField.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor, constant: -200),
            emailNameTextField.widthAnchor.constraint(equalToConstant: 350),
            emailNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.centerXAnchor.constraint(equalTo: emailNameTextField.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: emailNameTextField.centerYAnchor, constant: 70),
            passwordTextField.widthAnchor.constraint(equalToConstant: 350),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureImageConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: emailNameTextField.topAnchor, constant: -300),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

//MARK: --TextField Delegate
extension LoginViewController: UITextFieldDelegate {
    
}
