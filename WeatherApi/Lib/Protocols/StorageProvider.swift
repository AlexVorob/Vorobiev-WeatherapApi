//
//  StorageProvider.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

protocol StorageProvider {
    
    associatedtype ManagedObject
    associatedtype Storage
    
    func read(id: String) -> ManagedObject?
    func read() -> [ManagedObject]?
    func write(storage: ManagedObject)
}
