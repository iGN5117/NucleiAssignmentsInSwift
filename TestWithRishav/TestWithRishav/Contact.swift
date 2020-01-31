//
//  Contact.swift
//  TestWithRishav
//
//  Created by Nilesh Gajwani on 21/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation
import UIKit
class Contact: Comparable{
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        
        return lhs.getName() < rhs.getName()
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs === rhs
    }
    
    static var contactsList: [String : Contact] = [:]
    var firstName: String, lastName: String = ""
    var company: String
    var numbers: [String : String]
    var dates: [String : String]
    var emails: [String : String]
    var notes: String
    var image: UIImage?
    
    init(name: String, numbers: [String: String], emails: [String : String], dates: [String : String], company: String, image: UIImage?) {
        let fullNameArray = name.components(separatedBy: " ")
        self.firstName = fullNameArray[0]
        if fullNameArray.count > 1 {
            self.lastName = fullNameArray[1]
        }
        self.numbers = numbers
        self.company = "Company of \(name)"
        self.dates = dates
        self.emails = emails
        self.notes = ""
        self.company = company
        self.image = image
        Contact.contactsList[name] = self
    }
    
    convenience init() {
        self.init(name: "")
    }
    
    convenience init(name: String) {
        self.init(name: name, numbers: [:], emails: [:], dates: [:], company: "", image: nil)
    }
    
    func getName() -> String {
        return self.firstName + " " + self.lastName
    }
    
    func getNumber() -> String {
        if let mobileIsAdded = numbers["Mobile"] {
            return mobileIsAdded
        }
        else {
            return numbers[numbers.keys.first ?? ""] ?? "12DontComeHere3"
        }
    }
}
