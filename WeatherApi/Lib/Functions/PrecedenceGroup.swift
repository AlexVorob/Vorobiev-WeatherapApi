//
//  PrecedenceGroup.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/12/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

precedencegroup LeftFunctionApplicationPrecedence {
    associativity: left
    higherThan: AssignmentPrecedence
}

precedencegroup RightFunctionApplicationPrecedence {
    associativity: right
    higherThan: LeftFunctionApplicationPrecedence
}

precedencegroup CompositionPrecedence {
    associativity: left
    higherThan: RightFunctionApplicationPrecedence
}


