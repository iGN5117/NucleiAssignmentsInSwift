//
//  Node.swift
//  NucleiAssign3
//
//  Created by Nilesh Gajwani on 14/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation

class Node {
    let name: String
    static var id: Int = 0
    var parents, children: Set<Int>
    let nodeId: Int
    var extraInfo:[String:Any]
    init(name: String) {
        self.name = name
        nodeId = Node.id
        Node.id += 1
        parents = Set<Int>()
        children = Set<Int>()
        extraInfo = [:]
        
    }
    func getNodeParents() -> Set<Int> {
        return parents
    }
    func getNodeChildren() -> Set<Int> {
           return parents
    }
    func getNodeId() -> Int {
        return self.nodeId
    }
    func getName() -> String {
        return self.name
    }
    
    
    
    
    
}
