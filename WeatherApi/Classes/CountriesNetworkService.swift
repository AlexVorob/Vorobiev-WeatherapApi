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

class CountriesNetworkService {
    
    public func modelFilling(
        networkService: RequestService<[JSONCountry]>,
        model: CountriesModel
    ) {
        let urlCountry = URL(string: Constant.countryApi)
        guard let url = urlCountry else { return }
        
        networkService.getData(from: url) { data, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                guard let data = data else { return }
    
                //let countries = data.map(WeatherApi.countries)
                let countries = WeatherApi.countries(data)
                
                model.add(values: countries)
            }
        }
    }
}

fileprivate let countries: ([JSONCountry]) -> [Country] = { jsons in
    jsons
        .filter { $0.capital.count > 0 }
        .map (country)
}

fileprivate let country: (JSONCountry) -> Country = { json in
    Country(name: json.name, capital: json.capital)
}
