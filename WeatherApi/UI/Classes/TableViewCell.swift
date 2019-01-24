//
//  TableViewCell.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/15/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override var reuseIdentifier: String? {
        return toString(type(of: self))
    }
}
