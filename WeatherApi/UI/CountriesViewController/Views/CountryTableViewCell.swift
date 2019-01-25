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
        self.capitalLabel?.text = model.country.capital
        self.countryLabel?.text = model.country.name
        self.temperatureLabel?.text = model.weather?.temperature?.description ?? ""
        self.dateLabel?.text = model.weather?.date?.shortDescription ?? ""
    }
}
