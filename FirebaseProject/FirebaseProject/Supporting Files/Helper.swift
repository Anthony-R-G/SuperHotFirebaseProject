//
//  Helper.swift
//  FirebaseProject
//
//  Created by Anthony Gonzalez on 11/21/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

class Utilities {
    
   static func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    
    //Password must have 8 characters minimum, a special character, and a number
        return passwordTest.evaluate(with: password)
    }
}

//TODO: -- isEmailValid regular expression

extension String {
    var isValidEmail: Bool {

        // this pattern requires that an email use the following format:
        // [something]@[some domain].[some tld]
        let validEmailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", validEmailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {

        //this pattern requires that a password has at least one capital letter, one number, one lower case letter, and is at least 8 characters long
        //let validPasswordRegEx =  "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"

        //this pattern requires that a password be at least 8 characters long
        let validPasswordRegEx =  "[A-Z0-9a-z!@#$&*.-]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", validPasswordRegEx)
        return passwordPredicate.evaluate(with: self)
    }
}
