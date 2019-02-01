//
//  Wrapper.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/29/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Wrapper<Value>: ObservableObject<Value> {

    private let value: Value

    init(_ value: Value) {
        self.value = value
    }
    
    public func update<Result>(_ action: (Value) -> Result) -> Result {
        defer {
            self.notify(self.value)
        }
        
        return action(self.value)
    }
}
