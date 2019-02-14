//
//  CountryTableViewCell.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/15/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

public enum Event {
    
    case updateCell
}

class CountryTableViewCell: TableViewCell {
    
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var temperatureLabel: UILabel?
    @IBOutlet var countryLabel: UILabel?
    @IBOutlet var capitalLabel: UILabel?
    
    var country: Country? {
        didSet {
            self.prepareObserver()
            self.fillWithModel()
        }
    }
    
    public var eventHandler: F.Completion<Event>?
    
    private let cellObserver = CancellableProperty()

    private func fillWithModel() {
        let model = self.country
        
        self.capitalLabel?.text = model?.capital
        self.countryLabel?.text = model?.name
        self.temperatureLabel?.text = model?.weather?.temperature.celsius
        self.dateLabel?.text = model?.weather?.date?.shortDescription
    }
    
    private func prepareObserver() {
        self.cellObserver.value = self.country?.observer {_ in
            performOnMain { self.fillWithModel() }
            
            self.eventHandler?(.updateCell)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.cellObserver.value?.cancel()
    }
}
