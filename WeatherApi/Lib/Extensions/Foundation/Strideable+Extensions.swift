//
//  Int+Extension.swift
//  UI Task
//
//  Created by Alex Vorobiev on 10/26/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension Strideable where Self.Stride: SignedInteger, Self: ExpressibleByIntegerLiteral {
    
    func times ( _ transform: () -> ()) {
        (0..<self).forEach { _ in
            transform() }
    }
}

