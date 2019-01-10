//
//  RangeReplaceableCollection+Extension.swift
//  UI Task
//
//  Created by Alex Vorobiev on 10/26/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension RangeReplaceableCollection {
    
    mutating func safeRemoveFirst() -> Element? {
        return self.isEmpty ? nil : self.removeFirst()
    }
}
