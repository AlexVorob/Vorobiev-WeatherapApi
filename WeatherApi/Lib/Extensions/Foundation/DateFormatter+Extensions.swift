//
//  DateFormatter+Extensions.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    public var short: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter
    }
}
