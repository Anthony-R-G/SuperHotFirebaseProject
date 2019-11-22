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
