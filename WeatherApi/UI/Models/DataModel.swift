//
//  Model.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/16/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class DataModel: ObservableObject<BaseModel.BaseModelEvents> {

    var values: [BaseModel]
    
    init(values: [BaseModel] = []) {
        self.values = values
        
        super.init()
        self.prepareNotification()
    }
    
    func prepareNotification() {
        self.values.forEach { [weak self] model in
            (self?.notify).do { _ = model.observer(handler: $0) }
        }
    }
}

class Wrapper<Value>: ObservableObject<Value> {
    
    var value: Value {
        didSet {
            self.notify(state: self.value)
        }
    }
    
    init(_ value: Value) {
        self.value = value
    }
    
    public func update(_ action: (Value) -> ()) {
        action(self.value)
        
        self.notify(state: self.value)
    }
}
