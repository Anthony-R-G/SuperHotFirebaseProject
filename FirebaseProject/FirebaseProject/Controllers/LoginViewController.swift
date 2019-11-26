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
    lazy var emailTextField: UITextField = {
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
        button.addTarget(self, action: #selector(tryLogin), for: .touchUpInside)
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
    
    private func handleLoginResponse(with result: Result<(), Error>) {
        switch result {
        case .failure(let error):
            showAlert(message: error.localizedDescription)
        case .success:
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    //MARK: TODO - handle could not swap root view controller
                    return
            }
            
            //MARK: TODO - refactor this logic into scene delegate
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
//                if FirebaseAuthService.manager.currentUser?.photoURL = nil {
                    window.rootViewController = MainTabBarController()
//                } else {
//                    window.rootViewController = {
//                        let profileSetupVC = ProfileEditViewController()
//                        profileSetupVC.settingFromLogin = true
//                        return profileSetupVC
//                    }()
                })
//            }, completion: nil)
        }
    }
    
    @objc func tryLogin() {
           guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(message: "Please fill out all fields.")
               return
           }
           
           //MARK: TODO - remove whitespace (if any) from email/password
           
           guard email.isValidEmail else {
            showAlert(message: "Please enter a valid email")
               return
           }
           
           guard password.isValidPassword else {
               showAlert(message: "Please enter a valid password. Passwords must have at least 8 characters.")
               return
           }
           
           FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
               self.handleLoginResponse(with: result)
           }
       }
    
    
    
    @objc private func loginButtonPressed() {
        //Validate text fields
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.showAlert(message: "Please fill in all fields")
        } else {
            //Create cleaned versions of email and password textfields.
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
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
        [emailTextField, passwordTextField, loginButton, signUpButton, logoImageView].forEach({view.addSubview($0)})
        
        [emailTextField, passwordTextField, loginButton, signUpButton, logoImageView].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
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
            emailTextField.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor, constant: -200),
            emailTextField.widthAnchor.constraint(equalToConstant: 350),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor, constant: 70),
            passwordTextField.widthAnchor.constraint(equalToConstant: 350),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureImageConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -300),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

//MARK: --TextField Delegate
extension LoginViewController: UITextFieldDelegate {
    
}
