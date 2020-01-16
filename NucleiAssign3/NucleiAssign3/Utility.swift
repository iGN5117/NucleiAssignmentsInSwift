//
//  Utility.swift
//  NucleiAssign3
//
//  Created by Nilesh Gajwani on 16/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation
class Utility {


/**
 1. Get the immediate parents of a node, passing the node id as input parameter.
 2. Get the immediate children of a node, passing the node id as input parameter.
 3. Get the ancestors of a node, passing the node id as input parameter.
 4. Get the descendants of a node, passing the node id as input parameter.

     
     5. Delete dependency from a tree, passing parent node id and child node id.
 6. Delete a node from a tree, passing node id as input parameter. This should delete all the dependencies of the node.
 

     
7. Add a new dependency to a tree, passing parent node id and child node id. This should check for cyclic dependencies.
 8. Add a new node to tree. This node will have no parents and children. Dependency will be established by calling the 7 number API.
 
 
 
 */
    static func showMenu() {
        print("Welcome to the Dependency Graph UI")
        print("1. Add Node to the graph")
        print("2. Add dependency")
        print("3. Deleted dependency")
        print("4. Delete node")
        print("5. Get descendants")
        print("6. Get ancestors")
        print("7. Get parents (immediate ancestors")
        print("8. Get children (immediate descendants")
        print("9. Exit")
    }
}
