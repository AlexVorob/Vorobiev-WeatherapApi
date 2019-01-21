//
//  Constant.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

struct Constant {
    
    static let title = "Countries"
    static let celsius = "°C"
    static let weatherApi = "https://api.openweathermap.org/data/2.5/weather?q="
    static let weatherApiId = "&units=metric&APPID=ac6d05234841cc6b76ed2a4fcfda2b6b"
    static let countryApi = "https://restcountries.eu/rest/v2/all"
    
    static var getApiLink: (String) -> String = {
        return weatherApi + $0 + weatherApiId
    }
}
