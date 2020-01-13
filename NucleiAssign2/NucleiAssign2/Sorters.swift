//
//  Sorters.swift
//  NucleiAssign2
//
//  Created by Nilesh Gajwani on 13/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation
class Sorters {
    static func compareUser(_ u1: User, _ u2: User) -> Bool {
        if u1.fullName < u2.fullName {
            return true
        }
        else if u1.fullName > u2.fullName {
            return false
        }
        else if u1.fullName == u2.fullName {
            return compareUserRollNumber(u1, u2)
        }
        return true
    }
    static func compareUserRollNumber(_ u1: User, _ u2: User) -> Bool {
        return u1.rollNumber < u2.rollNumber
    }
    static func compareUserAge(_ u1: User, _ u2: User) -> Bool {
        return u1.age < u2.age
    }
    static func compareUserAddress(_ u1: User, _ u2: User) -> Bool {
        return u1.address < u2.address
    }
    static func compareUserDesc(_ u1: User, _ u2: User) -> Bool {
        return !compareUser(u1,u2)
    }
    static func compareUserRollNumberDesc(_ u1: User, _ u2: User) -> Bool {
        return !compareUserRollNumber(u1, u2)
    }
    static func compareUserAgeDesc(_ u1: User, _ u2: User) -> Bool {
        return !compareUserAge(u1, u2)
    }
    static func compareUserAddressDesc(_ u1: User, _ u2: User) -> Bool {
        return !compareUserAddress(u1, u2)
    }
    
}
