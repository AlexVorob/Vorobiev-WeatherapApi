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
    
    private func getURL(country: Country) -> URL? {
        let weatherPath = Constant.getApiLink(country.capital + "," + country.id)
        
        return weatherPath
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .flatMap { URL(string: Constant.weatherApi + $0) }
    }
    
    public func sheduledTask(country: Country, dataBaseService: DataBaseService<WeatherDataRealm>) -> NetworkTask {
        guard let url = self.getURL(country: country) else {
            return NetworkTask(urlSessionTask: URLSessionTask())
        }
        
        return self.networkService.sheduledTask(from: url) { result in
            result.analysis(
                success: { data in
//                    let decode = try? JSONDecoder().decode(JSONWeather.self, from: data)
//                     decode.do {
//                        dataBaseService.dataRealm.write(object: JSONWeatherRLM($0))
//                        country.weather = weather($0)
//                    }
                    
                    let data2 = dataBaseService.dataRealm.read(id: country.id)
                    data2.do {
                        country.weather = weatherRLM($0)
                    }
                },
                failure: { print($0) }
            )
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

fileprivate let weather: (JSONWeather) -> Weather = {
    Weather(
        date: Date(timeIntervalSince1970: TimeInterval($0.dt)),
        temperature: $0.main.temp)
}

fileprivate let weatherRLM: (JSONWeatherRLM) -> Weather = {
    Weather(
        date: Date(timeIntervalSince1970: TimeInterval($0.date)),
        temperature: $0.temperature)
}
