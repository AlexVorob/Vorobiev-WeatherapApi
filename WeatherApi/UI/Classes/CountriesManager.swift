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
    
    private let networkService = NetworkService<[JSONCountry]>()

    public func loadData(execute: @escaping ([Country]) -> ()) {
        let urlCountry = URL(string: Constant.countryApi)
        guard let url = urlCountry else { return }
        
        self.networkService.dataLoad(from: url) { data, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                guard let data = data else { return }
    
                let countries = data
                    .filter { $0.capital.count > 0 }
                    .map { Country(json: $0) }
                
                execute(countries)
            }
        }
    }
}
