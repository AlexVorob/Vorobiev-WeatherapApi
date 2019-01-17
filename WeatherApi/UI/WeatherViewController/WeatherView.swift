//
//  WeatherView.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    @IBOutlet var country: UILabel?
    @IBOutlet var temperature: UILabel?
    
    override func layoutSubviews() {
        self.country?.backgroundColor = Color.sand.opaque
        self.temperature?.backgroundColor = Color.lightSand.opaque
    }
    
    func fillWeather(model: Model) {
        //self.country?.text = model.values
        //self.temperature?.text = model.temperature
    }
}
