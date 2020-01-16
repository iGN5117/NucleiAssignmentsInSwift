//
//  main.swift
//  NucleiAssign3
//
//  Created by Nilesh Gajwani on 14/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation

var graph = DependencyGraph()

var continueLoop = true, continueLoopOuter = true
while(continueLoopOuter) {
    Utility.showMenu()
    if let choice = readLine() {
        switch choice {
        case "1":
            var newNode: Node
            continueLoop = true
            var name = ""
            var extraInformation: [String:String] = [:]
            while(continueLoop) {
                print("-name <name> to enter name of node (Optional)")
                print("-<key> <value> to add any extra information about the node")
                print("-done to add the node")
                if let inputStr = readLine() {
                    let keyValuePair = inputStr.components(separatedBy: " ")
                    let key = keyValuePair[keyValuePair.startIndex]
                    var value:String = ""
                    if(key != "-done") {
                        value = keyValuePair[keyValuePair.index(after: keyValuePair.startIndex)]
                    }
                    switch key {
                    case "-name":
                        name = value
                    case "-done":
                        continueLoop = false
                    default:
                        extraInformation[key] = value
                    }
                    
                }
            }
            if name != "" {
                if extraInformation.isEmpty {
                    newNode = Node(name: name)
                }
                else {
                    newNode = Node(name: name, extraInfo: extraInformation)
                }
            }
            else {
                if extraInformation.isEmpty {
                    newNode = Node()
                }
                else {
                    newNode = Node(extraInfo: extraInformation)
                }
            }
            print("Please note the node ID for future access to the node")
            graph.addNode(node: newNode)
        case "2":
            print("Enter IDs of parent and child node between which you want to add dependency seperated by a space")
            if let inputStr = readLine() {
                let KeyValuePair = inputStr.components(separatedBy: " ")
                let parentIdOptional = Int(KeyValuePair[KeyValuePair.startIndex])
                let childIdOptional = Int(KeyValuePair[KeyValuePair.index(after: KeyValuePair.startIndex)])
                if let parentId = parentIdOptional, let childId = childIdOptional {
                    graph.addDependency(parentId: parentId, childId: childId)
                }
                else {
                    print("Invalid format of parent or child Id")
                }
            }
        case "3":
            print("Enter IDs of parent and child node between which you want to delete dependency seperated by a space")
            if let inputStr = readLine() {
                let KeyValuePair = inputStr.components(separatedBy: " ")
                let parentIdOptional = Int(KeyValuePair[KeyValuePair.startIndex])
                let childIdOptional = Int(KeyValuePair[KeyValuePair.index(after: KeyValuePair.startIndex)])
                if let parentId = parentIdOptional, let childId = childIdOptional {
                    graph.deleteDependency(parentId: parentId, childId: childId)
                }
                else {
                    print("Invalid format of parent or child Id")
                }
            }
        case "4":
            print("Enter the id of the node you want to delete")
            if let inputStr = readLine() {
                if let deleteNodeId = Int(inputStr) {
                    graph.deleteNode(nodeId: deleteNodeId)
                }
                
            }
        case "5":
            var descendants: [Node]
            print("Enter the id of the node to get its descendants")
            if let inputStr = readLine() {
                if let nodeId = Int(inputStr) {
                    descendants = graph.getDescendants(nodeId: nodeId)
                    for descendant in descendants {
                        print("\(descendant.getName())")
                        for (key,value) in descendant.extraInfo {
                            print("\(key):  \(value)")
                        }
                    }
                }
                
                
            }
        case "6":
            var ancestors: [Node]
            print("Enter the id of the node to get its ancestors")
            if let inputStr = readLine() {
                if let nodeId = Int(inputStr) {
                    ancestors = graph.getAncestors(nodeId: nodeId)
                    for ancestor in ancestors {
                        print("\(ancestor.getName())")
                        for (key,value) in ancestor.extraInfo {
                            print("\(key):  \(value)")
                        }
                    }
                }
                
                
            }
        case "7":
            var parents: [Node]
            print("Enter the id of the node to get its parents")
            if let inputStr = readLine() {
                if let nodeId = Int(inputStr) {
                    parents = graph.getParents(nodeId: nodeId)
                    for parent in parents {
                        print("\(parent.getName())")
                        for (key,value) in parent.extraInfo {
                            print("\(key):  \(value)")
                        }
                    }
                }
                
                
            }
        case "8":
            var children: [Node]
            print("Enter the id of the node to get its children")
            if let inputStr = readLine() {
                if let nodeId = Int(inputStr) {
                    children = graph.getChildren(nodeId: nodeId)
                    for child in children {
                        print("\(child.getName())")
                        for (key,value) in child.extraInfo {
                            print("\(key):  \(value)")
                        }
                    }
                }
            }
        case "9":
            print("I hope the dependency graph was upto the mark!")
            continueLoopOuter = false
        default:
            print("Invalid Entry")
        }
    }
}

