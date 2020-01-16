//
//  Utility.swift
//  NucleiAssign3
//
//  Created by Nilesh Gajwani on 16/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import Foundation
class Utility {
    static func ancestorsUtil(ancestorIds:inout Set<Int>, parents: Set<Int>) {
        for parent in parents {
            ancestorIds.insert(parent)
        }
    }
}
