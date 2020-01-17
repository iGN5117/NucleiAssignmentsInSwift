//
//  User.swift
//  NucleiAssign2
//
//  Created by Nilesh Gajwani on 13/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation
class User: Comparable{
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.fullName < rhs.fullName
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.rollNumber < rhs.rollNumber
    }
    
    static var existingUsers = Set<Int>()
    let fullName, address: String
    let age, rollNumber: Int
    let courses:[Course]
    init(fullName: String, address: String, age: Int, rollNumber: Int, courses:[Course]) {
        self.fullName = fullName
        self.address = address
        self.age = age
        self.rollNumber = rollNumber
        self.courses = courses
    }
    
}
