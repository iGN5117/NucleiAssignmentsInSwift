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
    init() {
        nodes = [:]
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
           var childrenOfParent = parent.getNodeChildren()
           var parentsOfChild = child.getNodeParents()
            childrenOfParent.remove(childId)
            parentsOfChild.remove(parentId)
            parent.children = childrenOfParent
            child.parents = parentsOfChild
        }
        else {
            print("Invalid parent or child")
        }
    }
    @discardableResult
    func deleteNode(nodeId: Int) -> Node? {
       
        if let deletedNode = nodes[nodeId] {
            for parent in deletedNode.getNodeParents() {
                deleteDependency(parentId: parent, childId: nodeId)
            }
            for child in deletedNode.getNodeChildren() {
                deleteDependency(parentId: nodeId, childId: child)
            }
            nodes[nodeId] = nil
            return deletedNode
        }
        else {
            print("Invalid node entered...")
            return nil
        }
    }
    func addDependency(parentId: Int, childId: Int) {
        if let parent = nodes[parentId], let child = nodes[childId] {
            if(getAncestors(nodeId: parentId).contains(child)) {
                print("Cannot add dependecy")
                return
            }
            if(getDescendants(nodeId: childId).contains(parent)) {
                print("Cannot add dependecy")
                return
            }
            var childrenOfParent = parent.getNodeChildren()
            var parentsofChild = child.getNodeParents()
            childrenOfParent.insert(childId)
            parentsofChild.insert(parentId)
            parent.children = childrenOfParent
            child.parents = parentsofChild
            print("Successfully added dependency between \(parent.getName()) and \(child.getName())")
        }
        else {
            print("Invalid parent or child entered... Do you want to enter the nodes? (Y/N)")
//            if let input = readLine() {
//                if input == "Y" {
//                    if(parent == nil) {
//                        
//                    }
//                }
//                else if input == "N" {
//                    return
//                }
//                else {
//                    print("Invalid input entered..")
//                    return
//                }
//            } else {
//                print("Invalid input (should never reach here...)")
//            }
        }
    }
    func addNode(node: Node) {
        nodes[node.getNodeId()] = node
        print("Sucessfully added a node with name \(node.getName()) and with the ID: \(node.getNodeId())")
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
    func printDependencyGraph(graph: DependencyGraph) {
        for node in graph.nodes.values {
            var toPrint = "\(node.getName()) --------->  "
            let children = getChildren(nodeId: node.getNodeId())
            for child in children {
                toPrint.append("\(child.getName()) ")
            }
            print(toPrint)
        }
    }
}
