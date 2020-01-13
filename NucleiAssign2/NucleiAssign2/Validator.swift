//
//  Validator.swift
//  NucleiAssign2
//
//  Created by Nilesh Gajwani on 13/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation
class Validator {
    static func validateName(name: String) -> Bool {
        if(!(Utility.isAlpha(str: name)))
        {
            return false
        }
        return true
    }
    static func validateAge(age: Int) -> Bool {
        if age > 110 || age < 0 {
            return false
        }
        return true
    }
    
}


