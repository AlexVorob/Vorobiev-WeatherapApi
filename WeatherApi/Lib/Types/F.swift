//
//  F.swift
//  UI Task
//
//  Created by Alex Vorobiev on 12/28/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

enum F {
    
    typealias Completion<Value> = (Value) -> ()
    typealias Execute<Result> = () -> Result
}

func when<Result>(_ condition: Bool, execute: F.Execute<Result?>) -> Result? {
    return condition ? execute() : nil
}

func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}
