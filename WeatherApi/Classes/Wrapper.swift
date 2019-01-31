//
//  Wrapper.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/29/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Wrapper<Value>: ObservableObject<Value> {
    
    var value: Value {
        didSet {
            self.notify(self.value)
        }
    }
    
    init(_ value: Value) {
        self.value = value
    }
    
    public func update(_ action: F.Completion<Value>) {
        action(self.value)
        
        self.notify(self.value)
    }
}
