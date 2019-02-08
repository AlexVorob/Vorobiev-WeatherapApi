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
    
    var countriesModel: CountriesModel?
    
    private let cancellableObserver = CancellableProperty()

    func fillWithModel(_ model: Country, execute: @escaping F.Action) {

        self.capitalLabel?.text = model.capital
        self.countryLabel?.text = model.name
        
        self.temperatureLabel?.text = model.weather?.temperature.celsius
        self.dateLabel?.text = model.weather?.date?.shortDescription
        
        self.cancellableObserver.value = self.countriesModel?.observer {_ in
            print("Cell observer")
            dispatchOnMain {
                self.capitalLabel?.text = model.capital
                self.countryLabel?.text = model.name
                self.temperatureLabel?.text = model.weather?.temperature.celsius
                self.dateLabel?.text = model.weather?.date?.shortDescription
                execute()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.cancellableObserver.value?.cancel()
    }
}
