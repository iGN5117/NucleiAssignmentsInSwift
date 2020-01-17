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
        //        for character in str {
        //            switch character {
        //            case "a"..."z":
        //                result = true
        //            case "A"..."Z":
        //                result = true
        //            case " ":
        //                result = true
        //            default:
        //                result = false
        //            }
        //        }
        let letters = NSCharacterSet.letters
        let range = str.rangeOfCharacter(from: letters)
        if range == nil {
            return true
        }
        return false
    }
    static func showUsers(_ sortedUsers: [User]) {
        print("---------------------------------------------------------------------------------------------------------------------------------")
        
        print("Name   Roll   Number   Age   Address   Courses")
        
        print("---------------------------------------------------------------------------------------------------------------------------------")
        
        for user in sortedUsers {
            var toPrint = "\(user.fullName)   \(user.rollNumber)   \(user.age)   \(user.address)   "
            
            let courses = user.courses
            for course in courses {
                toPrint.append("\(course) ")
            }
            print(toPrint)
            print("---------------------------------------------------------------------------------------------------------------------------------")
            
        }
    }
    static func clearAll(name: inout String, rollNumber: inout Int, age: inout Int, address: inout String, courses: inout [Course]) {
        name = ""
        rollNumber = 0
        age = 0
        address = ""
        courses = []
    }
}
