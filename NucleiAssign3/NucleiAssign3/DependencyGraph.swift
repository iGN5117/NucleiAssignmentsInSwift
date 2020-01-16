//
//  DependencyGraph.swift
//  NucleiAssign3
//
//  Created by Nilesh Gajwani on 14/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation
class DependencyGraph: Operations {
    var nodes: [Int:Node]
    var existingNames: Set<String>
    init() {
        nodes = [:]
        existingNames = Set<String>()
    }
    
    
    func getParents(nodeId: Int) -> [Node] {
        var parents: [Node] = []
        if let node = nodes[nodeId] {
            let nodeParents = node.getNodeParents()
            for parentId in nodeParents {
                if let parent = nodes[parentId] {
                    parents.append(parent)
                }
                else {
                    print("Parent not found....")
                }
            }
        }
        else {
            print("Entered node not found")
        }
        return parents
    }
    func getChildren(nodeId: Int) -> [Node] {
        var children: [Node] = []
        if let node = nodes[nodeId] {
            let nodeChildren = node.getNodeChildren()
            for childId in nodeChildren {
                if let child = nodes[childId] {
                    children.append(child)
                }
                else {
                      print("Child not found...")
                }
            }
        }
        else {
            print("Node not found....")
        }
        return children
    }
    func getAncestors(nodeId: Int) -> [Node] {
        var ancestors: [Node] = []
        let parents = getParents(nodeId: nodeId)
       // ancestors.append(contentsOf: parents)
        ancestorsUtil(ancestors: &ancestors, parents: parents)
        return ancestors
       
    }
    func getDescendants(nodeId: Int) -> [Node] {
        var descendants: [Node] = []
        let children = getChildren(nodeId: nodeId)
        descendantsUtil(descendants: &descendants, children: children)
        return descendants
    }
    func deleteDependency(parentId: Int, childId: Int) {
        if let parent = nodes[parentId], let child = nodes[childId] {
            
        }
    }
    func deleteNode(nodeId: Int) -> Node? {
        
    }
    func addDependency(parentId: Int, childId: Int) {
        
    }
    func addNode(node: Node) {
        
    }
    func ancestorsUtil(ancestors: inout [Node], parents: [Node]) {
        for node in parents {
            ancestors.append(node)
            ancestorsUtil(ancestors: &ancestors, parents: getParents(nodeId: node.getNodeId()))
        }
    }
    func descendantsUtil(descendants: inout [Node], children: [Node]) {
        for node in children {
            descendants.append(node)
            descendantsUtil(descendants: &descendants, children: getChildren(nodeId: node.getNodeId()))
        }
    }
}
