//
//  Operators.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/12/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

infix operator •: CompositionPrecedence
func • <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}

infix operator §: RightFunctionApplicationPrecedence
public func § <A, B> (f: (A) -> B, value: A) -> B {
    return f(value)
}

infix operator <|: RightFunctionApplicationPrecedence
public func <| <A, B> (f: (A) -> B, value: A) -> B {
    return f § value
}

infix operator |>: LeftFunctionApplicationPrecedence
public func |> <A, B> ( value: A, f: (A) -> B) -> B {
    return f § value
}
