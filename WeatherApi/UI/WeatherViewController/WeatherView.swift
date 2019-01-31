//
//  WeatherView.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    
    static let celsius = UnitTemperature.celsius.symbol
}

class WeatherView: UIView {

    @IBOutlet var country: UILabel?
    @IBOutlet var temperature: UILabel?
    
    override func layoutSubviews() {
        self.country?.backgroundColor = Color.sand.opaque
        self.temperature?.backgroundColor = Color.lightSand.opaque
    }
    
    func fillWeather(with model: DataModel) {
        self.country?.text = model.countryWrapper.value.capital
        self.temperature?.text = model.weatherWrapper.value?.temperature.celsius
    }
}
