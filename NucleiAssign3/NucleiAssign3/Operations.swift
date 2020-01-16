//
//  Operations.swift
//  NucleiAssign3
//
//  Created by Nilesh Gajwani on 14/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation
protocol Operations {
    func getParents(nodeId: Int) -> [Node]
    func getChildren(nodeId: Int) -> [Node]
    func getAncestors(nodeId: Int) -> [Node]
    func getDescendants(nodeId: Int) -> [Node]
    func deleteDependency(parentId: Int, childId: Int)
    @discardableResult
    func deleteNode(nodeId: Int) -> Node?
    func addDependency(parentId: Int, childId: Int)
    func addNode(node: Node)
}
