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
        return weatherApi + $0 + weatherApiId
    }
}

class WeatherManager: ObservableObject<Weather> {
    
    private let networkService: NetworkService<JSONWeather>?
    var country: Country?
    
    init(_ networkService: NetworkService<JSONWeather>) {
        self.networkService = networkService
//        self.country = country
    }
    
    private func getURL(capital: String) -> URL? {
        let weatherPath = Constant.getApiLink(capital)
        let urlWeather = weatherPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = urlWeather else { return nil }
        return URL(string: url)
    }
    
    public func loadData(execute: @escaping F.Completion<Country>) {
        guard let url = self.getURL(capital: self.country!.capital) else { return }
        
        self.networkService?.getData(from: url) { model, error in
            guard let modelBase = model else { return }
            
            self.country?.weather = Weather(json: modelBase)
            // FIX: notify for update weather
            
            execute(self.country!)
        }
    }
}
