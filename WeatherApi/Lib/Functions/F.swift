//
//  F.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 12/28/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

public enum F {
    
    public typealias Completion<Value> = (Value) -> ()
    public typealias Execute<Result> = () -> Result
    public typealias Action = () -> ()
}

public func when<Result>(_ condition: Bool, execute: F.Execute<Result?>) -> Result? {
    return condition ? execute() : nil
}

public func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}

public func toString(_ cls: AnyClass) -> String {
    return String(describing: cls)
}

public func performOnMain(_ action: @escaping F.Action) {
    DispatchQueue.main.async(execute: action)
}

@discardableResult
public func side<Value>(_ value: Value, execute: (inout Value) -> ()) -> Value {
    var mutableValue = value
    execute(&mutableValue)
    
    return mutableValue
}

public func sideEffect<Value>(action: @escaping (Value) -> ()) -> (Value) -> Value {
    return {
        action($0)
    
        return $0
    }
}

public func identity<Value>(value: Value) -> Value {
    return value
}

public func ignoreInput<Value, Result>(_ action: @escaping () -> Result) -> (Value) -> Result {
    return { _ in
        action()
    }
}

public func returnValue<Value>(_ value: Value) -> () -> (Value) {
    return { value }
}

public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in
        { f(a,$0) }
    }
}

public func uncurry<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (A, B) -> C {
    return { f($0)($1) }
}

public func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    return { b in
        { f($0)(b) }
    }
}

public func call<Value>(_ action: () -> Value) -> Value {
    return action()
}
