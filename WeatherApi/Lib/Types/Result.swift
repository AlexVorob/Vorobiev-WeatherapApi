//
//  Result.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/12/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public func lift<Value, Error: Swift.Error>(_ value: Value) -> Result<Value, Error> {
    return .success(value)
}

public func lift<Value, Error: Swift.Error>(_ error: Error) -> Result<Value, Error> {
    return .failure(error)
}

public enum Result<Value, Error: Swift.Error> {
    
    case success(Value)
    case failure(Error)
    
    public var value: Value? {
        
        return self.optional § analysis
    }
    
    public var error: Error? {
        
        return self.analysis(success: { _ in nil }, failure: identity)
    }
    
    public init(value: Value?, error: Error?, `default`: Error) {
        self = error.map { .failure($0) } ??
            value.map { .success($0) } ??
            .failure(`default`)
        
    }
    
    public func analysis<ReturnType>(success: (Value) -> ReturnType, failure: (Error) -> ReturnType) -> ReturnType {
        switch self {
        case let .success(wrapped): return success(wrapped)
        case let .failure(wrapped): return failure(wrapped)
        }
    }
    
    public func bimap<NewValue, NewError>(
        success: (Value) -> NewValue,
        failure: (Error) -> NewError
    )
        -> Result<NewValue, NewError>
    {
        return self.analysis(success: { .success(success § $0) } , failure: { .failure(failure § $0) })
    }
    
    public func mapValue<NewValue>(_ transform: (Value) -> NewValue) -> Result<NewValue, Error> {
        return self.bimap(success: transform, failure: identity)
    }
    
    public func mapError<NewError >(_ transform: (Error) -> NewError) -> Result<Value, NewError> {
        return self.bimap(success: identity, failure: transform)
    }
    
    public func biflatMap<NewValue, NewError>(
        success: (Value) -> Result<NewValue, NewError>,
        failure: (Error) -> Result<NewValue, NewError>
    )
        -> Result<NewValue, NewError>
    {
        return self.analysis(success: success, failure: failure)
    }
    
    public func flatMapValue<NewValue>(_ transform: (Value) -> Result<NewValue, Error>) -> Result<NewValue, Error> {
        return self.biflatMap(success: transform, failure: { .failure($0) })
    }
    
    public func flatMapError<NewError>(_ transform: (Error) -> Result<Value, NewError>) -> Result<Value, NewError> {
        return self.biflatMap(success: { .success($0) }, failure: transform)
    }
    
    private func optional<Ignored, Result>(_ f: ((Result) -> Result?, (Ignored) -> Result?) -> Result?) -> Result? {
        return f(identity, ignoreInput § returnValue § nil)
    }
}
