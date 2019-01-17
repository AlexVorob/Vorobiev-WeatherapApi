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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWithModel(model: AbstractModel) {
        self.capitalLabel?.text = model.country.capital
        self.countryLabel?.text = model.country.name
    }
    
    func addDateandTemp(model: Model) {
        //self.temperatureLabel?.text = model.values.temperature
    }
}
