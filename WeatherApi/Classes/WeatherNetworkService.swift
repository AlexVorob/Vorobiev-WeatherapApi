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

class WeatherNetworkService<Type: StorageProvider>
where Type.ManagedObject == Weather {
    
    private let requestService: RequestServiceType
    private let dataBaseService: DataBaseService<Type>
    
    init(requestService: RequestServiceType, dataBaseService: DataBaseService<Type>) {
        self.requestService = requestService
        self.dataBaseService = dataBaseService
    }
    
    private func getURL(country: Country) -> URL? {
        let weatherPath = Constant.getApiLink(country.capital + "," + country.id)
        
        return weatherPath
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .flatMap { URL(string: Constant.weatherApi + $0) }
    }
    
    public func sheduledTask(country: Country) -> NetworkTask {
        guard let url = self.getURL(country: country) else {
            return NetworkTask(urlSessionTask: URLSessionTask())
        }
        
        return self.requestService.sheduledTask(from: url) { result in
            result.analysis(
                success: { data in
                    let decoder = try? JSONDecoder().decode(JSONWeather.self, from: data)
                    if let deco = decoder {
                        let weatherData = weather(deco, country.id)
                        country.weather = weatherData
                        self.dataBaseService.value.write(storage: weatherData)
                        
                    } else {
                        let data = self.dataBaseService.value.read(id: country.id)
                        data.do {
                            country.weather = $0
                        }
                    }
                },
                failure: { print($0) }
            )
        }
    }
}

fileprivate let weather: (JSONWeather, String) -> Weather = { json, id in
    Weather(
        date: Date(timeIntervalSince1970: TimeInterval(json.dt)),
        temperature: json.main.temp, id: id)
}
