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
        requestService: RequestServiceType,
        model: CountriesModel,
        dataBaseService: DataBaseService<CountryDataRealm>
    )
        -> NetworkTask
    {
        let urlCountry = URL(string: Constant.countryApi)
        guard let url = urlCountry else { return NetworkTask(urlSessionTask: URLSessionTask()) }
        
        return requestService.sheduledTask(from: url) { result in
            result.mapValue { data in
                let decode = try? JSONDecoder().decode([JSONCountry].self, from: data)
                decode.do { model.add(values: WeatherApi.countries($0)) }
                
                //dataBaseService.dataRealm.write(country: <#T##CountryRLM#>)
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
