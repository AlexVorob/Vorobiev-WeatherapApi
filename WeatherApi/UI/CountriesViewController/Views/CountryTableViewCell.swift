//
//  CountryTableViewCell.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/15/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class CountryTableViewCell: TableViewCell {
    
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var temperatureLabel: UILabel?
    
    @IBOutlet var countryLabel: UILabel?
    @IBOutlet var capitalLabel: UILabel?
    
    func fillWithModel(model: BaseModel) {
        let modelCountry = model.country.value
        let modelWeather = model.weather.value
        
        self.capitalLabel?.text = modelCountry.capital
        self.countryLabel?.text = modelCountry.name
        self.temperatureLabel?.text = modelWeather?.temperature?.description ?? ""
        self.dateLabel?.text = modelWeather?.date?.shortDescription ?? ""
    }
}
