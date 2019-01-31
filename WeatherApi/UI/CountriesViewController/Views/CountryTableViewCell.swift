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
    
    func fillWithModel(_ model: DataModel) {
        let modelCountry = model.countryWrapper.value
        let modelWeather = model.weatherWrapper.value
        
        self.capitalLabel?.text = modelCountry.capital
        self.countryLabel?.text = modelCountry.name
        self.temperatureLabel?.text = modelWeather?.temperature.celsius
        self.dateLabel?.text = modelWeather?.date?.shortDescription
    }
}
