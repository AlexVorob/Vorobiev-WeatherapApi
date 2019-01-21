//
//  Date+Extensions.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

extension Date {
    
    public var shortDescription: String {
        return DateFormatter().short.string(from: self)
    }
}
