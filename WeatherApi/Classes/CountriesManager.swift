//
//  CountriesManager.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/25/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

fileprivate struct Constant {
    
    static let countryApi = "https://restcountries.eu/rest/v2/all"
}

class CountriesManager {
    
    public func loadData(
        networkService: NetworkService<[JSONCountry]>,
        model: DataModels
    ) {
        let urlCountry = URL(string: Constant.countryApi)
        guard let url = urlCountry else { return }
        
        networkService.getData(from: url) { data, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                guard let data = data else { return }
    
                let countries = data
                    .filter { $0.capital.count > 0 }
                    .map { Country(name: $0.name, capital: $0.capital, weather: nil) }
                
                model.add(values: countries)
            }
        }
    }
}
