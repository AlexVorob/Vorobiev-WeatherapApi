//
//  WeatherView.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    @IBOutlet var label: UILabel?
    
    override func layoutSubviews() {
        self.label?.backgroundColor = Color.red.opaque
    }
}
