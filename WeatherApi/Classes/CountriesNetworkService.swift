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

class CountriesNetworkService<Type: StorageProvider>
where Type.ManagedObject == JSONCountry {
    
    private let requestService: RequestServiceType
    private let dataBaseService: DataBaseService<Type>
    
    init(requestService: RequestServiceType, dataBaseService: DataBaseService<Type>) {
        self.requestService = requestService
        self.dataBaseService = dataBaseService
    }

    public func modelFilling(
        model: CountriesModel
    )
        -> NetworkTask
    {
        let urlCountry = URL(string: Constant.countryApi)
        guard let url = urlCountry else { return NetworkTask(urlSessionTask: URLSessionTask()) }
        
        return requestService.sheduledTask(from: url) { result in
            result.analysis(
                success: { data in
                    let decoder = try? JSONDecoder().decode([JSONCountry].self, from: data)
                    if let decode = decoder {
                        decode.filter { $0.capital.count > 0 }
                            .forEach {
                                self.dataBaseService.value.write(storage: $0) }
                        model.add(values: countries(decode))
                    } else {
                        let dataCountrise = self.dataBaseService.value.read()
                        dataCountrise.do {
                            model.add(values: $0.map {
                                country($0)
                            })
                        }
                    }
                },
                failure: { print($0) }
            )
        }
    }
}

fileprivate let countries: ([JSONCountry]) -> [Country] = { jsons in
    jsons
        .filter { $0.capital.count > 0 }
        .map (country)
}

fileprivate let country: (JSONCountry) -> Country = { json in
    Country(id: json.alpha2Code, name: json.name, capital: json.capital)
}

fileprivate let countryRLM: (JSONCountryRLM) -> Country = { jsons in
    Country(id: jsons.id, name: jsons.name, capital: jsons.capital)
}
