//
//  Optional.swift
//  UI Task
//
//  Created by Alex Vorobiev on 10/23/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension Optional {
    
    func `do`(_ action: (Wrapped) -> ()) {
        self.map(action)
    }
    
    func apply<Result>(_ transform: ((Wrapped) -> Result)?) -> Result? {
        return self.flatMap {
            transform?($0)
        }
    }
}
