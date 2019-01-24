//
//  UITableView+Extensions.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/16/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ cellClass: AnyClass) {
        self.register(UINib(cellClass), forCellReuseIdentifier: toString(cellClass))
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(cellClass: Cell.Type, for indexPath: IndexPath, configure: (Cell) -> ()) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath)
        cast(cell).do(configure)
        
        return cell
    }
    
    func dequeueReusableCell(withCellClass cellClass: AnyClass, for indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath)
    }
}
