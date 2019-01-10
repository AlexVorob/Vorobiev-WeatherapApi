//
//  CountriesParser.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class CountriesParser {
    
    let country: String
    let capital: String
    
    init(country: String, capital: String) {
        self.country = country
        self.capital = capital
    }
    
//    func parse() {
//        let url = URL(string: "restcountries.eu/rest/v2/all")
//        
//        URLSession.shared.dataTask(with: url) { (date, respose, error) in
//            guard let data = date else { return }
//            do {
//                let countries = try JSONDecoder().decode([Country].self, from: data)
//                self.model.values = countries
//                
//            } catch let jsonError {
//                print("Error", jsonError)
//            }
//            }.resume()
//    }
}
