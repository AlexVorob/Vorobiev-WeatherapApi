//
//  DataBaseService.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class DataBaseService<Provider: StorageProvider> {
    
    public let value: Provider
    
    init(provider: Provider) {
        self.value = provider
    }
}

class CountryDataRLM: DataRealm<CountryRLM> { }

class WeatherDataRLM: DataRealm<WeatherRLM> { }
