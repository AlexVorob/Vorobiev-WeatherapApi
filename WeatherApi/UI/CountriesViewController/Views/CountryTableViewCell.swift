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
        let modelCountry = model.country
        let modelWeather = model.weather
        
        self.capitalLabel?.text = modelCountry.value.capital
        self.countryLabel?.text = modelCountry.value.name
        self.temperatureLabel?.text = modelWeather.value?.temperature?.description ?? ""
        self.dateLabel?.text = modelWeather.value?.date?.shortDescription ?? ""
    }
}
