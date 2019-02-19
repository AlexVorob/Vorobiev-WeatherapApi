//
//  WeatherManager.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/25/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

fileprivate struct Constant {

    static let weatherApi = "https://api.openweathermap.org/data/2.5/weather?q="
    static let weatherApiId = "&units=metric&APPID=ac6d05234841cc6b76ed2a4fcfda2b6b"

    static var getApiLink: (String) -> String = {
        return $0 + weatherApiId
    }
}

class WeatherNetworkService {
    
    private let networkService: RequestServiceType
    
    init(networkService: RequestServiceType) {
        self.networkService = networkService
    }
    
    private func getURL(capital: String) -> URL? {
        let weatherPath = Constant.getApiLink(capital)
        
        return weatherPath
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .flatMap { URL(string: Constant.weatherApi + $0) }
    }
    
    public func sheduledTask(country: Country) -> NetworkTask {
        guard let url = self.getURL(capital: country.capital) else {
            return NetworkTask(urlSessionTask: URLSessionTask())
        }
        
        return self.networkService.sheduledTask(from: url) { result in
            result.mapValue { data in
                let decode = try? JSONDecoder().decode(JSONWeather.self, from: data)
                decode.do { country.weather = weather($0) }
                // обернуть в резалт все
//                if let decode = decode {
//                    let weather = weather(decode)
//                    // обернуть в Везеррлм и записать в реалм
//                    country.weather = weather
//
//                } else {
//                    country.weather =
//                    // достать из реалма если нил
//                }
            }
        }
    }
}

fileprivate let weather: (JSONWeather) -> Weather = {
    Weather(
        date: Date(timeIntervalSince1970: TimeInterval($0.dt)),
        temperature: $0.main.temp)
}
