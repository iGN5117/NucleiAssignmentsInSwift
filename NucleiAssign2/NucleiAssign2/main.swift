//
//  main.swift
//  NucleiAssign2
//
//  Created by Nilesh Gajwani on 13/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation

var name = "" , address = ""
var age = 0, rollNumber = 0
var courses: [Course] = []
var continueLoop = true
var input:String
var users:[Int:User] = [:]

while(continueLoop) {
    print("1. Add a new user")
    print("2. View existing users")
    print("3. Delete an existing user")
    print("4. Exit")
    if let optionalInput = readLine() {
        if let choice = Int(optionalInput) {
            if choice == 1 {
                while(continueLoop) {
                    print("Enter the rollNumber of the user: ")
                    if let optionalInput = readLine() {
                        if let optionalRollNumber = Int(optionalInput) {
                            if(User.existingUsers.contains(optionalRollNumber)) {
                                print("User with roll number: \(optionalRollNumber) already exists! Enter new roll number at the prompt")
                            }
                            else {
                                rollNumber = optionalRollNumber
                                User.existingUsers.insert(rollNumber)
                                break
                            }
                        }
                        
                    }
                }
                
                while(continueLoop) {
                    print("Enter the full name of the user: ")
                    if let optionalInput = readLine() {
                        if(Validator.validateName(name: optionalInput)) {
                            name = optionalInput
                            break
                        }
                        else {
                            print("Invalid name entered....")
                        }
                    }
                }
                
                while(continueLoop) {
                    print("Enter the age of the user: ")
                    if let optionalInput = readLine() {
                        if let optionalAge = Int(optionalInput) {
                            if(Validator.validateAge(age: optionalAge)) {
                                age = optionalAge
                                break
                            }
                            else {
                                print("Invalid age entered....")
                            }
                        }
                        
                    }
                }
                
                print("Enter the address of the user: ")
                if let optionalInput = readLine() {
                    address = optionalInput
                }
                var enteredCourses = 0
                while(continueLoop) {
                    
                    print("Enter atleast \(4 - enteredCourses) course(s) opted by the user in a space seperated format: ")
                    if let optionalInput = readLine() {
                        let courseString = optionalInput.components(separatedBy: " ")
                        for course in courseString {
                            if let actualCourse = try?Course(rawValue: course) {
                                courses.append(actualCourse)
                                enteredCourses+=1
                            }
                            else {
                                print("Invalid course \(course) entered, discarding it...")
                            }
                        }
                        if courses.count >= 4 {
                            break
                        }
                        
                    }
                }
                for c in courses {
                    print(c)
                }
                users[rollNumber] = User(fullName: name, address: address, age: age, rollNumber: rollNumber, courses: courses)
                Utility.clearAll(name: &name, rollNumber: &rollNumber, age: &age, address: &address, courses: &courses)
                
            }
            else if choice == 2 {
                print("Select the field you want to filter existing users on: ")
                print("1. Name")
                print("2. Age")
                print("3. Roll number")
                print("4. Address")
                if let optionalInput = readLine() {
                    if let choice = Int(optionalInput) {
                        var sortedUsers = [User](users.values)
                        var descendingChoice = "N"
                        print("Do you want to sort in descending order? Y/N")
                        if let optionalInput = readLine() {
                            descendingChoice = optionalInput
                        }
                        
                        switch choice {
                        case 1:
                            if(descendingChoice == "N") {
                                sortedUsers.sort(by: Sorters.compareUser)
                                Utility.showUsers(sortedUsers)
                            }
                            else {
                                sortedUsers.sort(by: Sorters.compareUserDesc)
                                Utility.showUsers(sortedUsers)
                            }
                        case 2:
                            if(descendingChoice == "N") {
                                sortedUsers.sort(by: Sorters.compareUserAge)
                                Utility.showUsers(sortedUsers)
                            }
                            else {
                                sortedUsers.sort(by: Sorters.compareUserAgeDesc)
                                Utility.showUsers(sortedUsers)
                            }
                        case 3:
                            if(descendingChoice == "N") {
                                sortedUsers.sort(by: Sorters.compareUserRollNumber)
                                Utility.showUsers(sortedUsers)
                            }
                            else {
                                sortedUsers.sort(by: Sorters.compareUserRollNumberDesc)
                                Utility.showUsers(sortedUsers)
                            }
                        case 4:
                            if(descendingChoice == "N") {
                                sortedUsers.sort(by: Sorters.compareUserAddress)
                                Utility.showUsers(sortedUsers)
                            }
                            else {
                                sortedUsers.sort(by: Sorters.compareUserAddressDesc)
                                Utility.showUsers(sortedUsers)
                            }
                        default:
                            print("Invalid choice entered....")
                        }
                    }
                }
                
            }
            else if choice == 3 {
                print("Enter the roll number of the user you want to remove: ")
                if let optionalInput = readLine() {
                    if let removeRoll = Int(optionalInput) {
                        print("removing user: \(users)")
                        users[removeRoll] = nil
                    }
                    else {
                        print("Invalid roll number entered.....")
                    }
                }
            }
            else if choice == 4 {
                break
            }
                else {
                    print("Invalid choice entered.....")
                }
            }
        }
        
    }
    

