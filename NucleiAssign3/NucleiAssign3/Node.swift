//
//  Node.swift
//  NucleiAssign3
//
//  Created by Nilesh Gajwani on 14/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation

class Node: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs === rhs
    }
    
    let name: String
    static var id: Int = 0
    var parents, children: Set<Int>
    let nodeId: Int
    var extraInfo:[String:Any]
    convenience init() {
        self.init(name: "Node\(Node.id)", extraInfo: [:])
    }
    convenience init(name: String) {
        self.init(name: name, extraInfo: [:])
    }
    convenience init(extraInfo: [String:String]) {
        self.init(name: "Node\(Node.id)", extraInfo: extraInfo)
    }
     init(name: String, extraInfo: [String:String]) {
        self.name = name
        self.extraInfo = extraInfo
        nodeId = Node.id
        Node.id += 1
        parents = Set<Int>()
        children = Set<Int>()
    }
    func getNodeParents() -> Set<Int> {
        return parents
    }
    func getNodeChildren() -> Set<Int> {
           return children
    }
    func getNodeId() -> Int {
        return self.nodeId
    }
    func getName() -> String {
        return self.name
    }
    
    
    
    
    
}
