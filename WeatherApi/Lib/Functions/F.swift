//
//  F.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 12/28/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

enum F {
    
    typealias Completion<Value> = (Value) -> ()
    typealias Execute<Result> = () -> Result
    typealias Action = () -> ()
}

func when<Result>(_ condition: Bool, execute: F.Execute<Result?>) -> Result? {
    return condition ? execute() : nil
}

func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}

func toString(_ cls: AnyClass) -> String {
    return String(describing: cls)
}

func performOnMain(_ action: @escaping F.Action) {
    DispatchQueue.main.async(execute: action)
}

@discardableResult
func side<Value>(_ value: Value, execute: (inout Value) -> ()) -> Value {
    var mutableValue = value
    execute(&mutableValue)
    
    return mutableValue
}

public func identity<Value>(value: Value) -> Value {
    return value
}

public func ignoreInput<Value, Result>(_ action: @escaping () -> Result) -> (Value) -> Result {
    return { _ in
        action()
    }
}

public func returnValue<Value>(_ value: Value) -> () -> Value {
    return { value }
}
