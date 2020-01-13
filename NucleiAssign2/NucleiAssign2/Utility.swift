//
//  Utility.swift
//  NucleiAssign2
//
//  Created by Nilesh Gajwani on 13/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation
class Utility {
    static func isAlpha(str: String) -> Bool {
        var result = true
        for character in str {
            switch character {
            case "a"..."z":
                result = true
            case "A"..."Z":
                result = true
            case " ":
                result = true
            default:
                result = false
            }
        }
        return result
    }
    static func showUsers(_ sortedUsers: [User]) {
        print("---------------------------------------------------------------------------------------------------------------------------------")
        
        print("Name   Roll   Number   Age   Address   Courses")
        
        print("---------------------------------------------------------------------------------------------------------------------------------")
        
        for user in sortedUsers {
            print("\(user.fullName)   \(user.rollNumber)   \(user.age)   \(user.address)   ")
            print("---------------------------------------------------------------------------------------------------------------------------------")
            
        }
    }
}
