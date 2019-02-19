//
//  DataBaseService.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/18/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import RealmSwift

public class DataBaseService<DataRealm: StorageProtocol> {
    
    public let dataRealm: DataRealm
    
    public init(dataRealm: DataRealm) {
        self.dataRealm = dataRealm
    }
}

public class CountryDataRealm: StorageProtocol {

    public typealias ManagedObject = CountryRLM
    
    private let realm: Realm?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    public func read(id: String) -> CountryRLM? {
        return realm?.object(ofType: CountryRLM.self, forPrimaryKey: id)
    }
    
    public func write(country: CountryRLM) {
        try? self.realm?.write {
            self.realm?.add(country)
        }
    }
}

public class WeatherDataRealm: StorageProtocol {
    
    public typealias ManagedObject = WeatherRLM
    
    private let realm: Realm?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    public func read(id: String) -> WeatherRLM? {
        return realm?.object(ofType: WeatherRLM.self, forPrimaryKey: id)
    }
    
    public func write(country: WeatherRLM) {
        try? self.realm?.write {
            self.realm?.add(country)
        }
    }
}

// Provider
public protocol StorageProtocol {
    
    associatedtype ManagedObject
    
    func write(country: ManagedObject)
    
    func read(id: String) -> ManagedObject?
}

public class RLMModel: Object {
    
    private struct Property {
        static let id = "id"
    }
    
    @objc dynamic var id = ""
    
    @objc open override class func primaryKey() -> String? {
        return Property.id
    }
}

public class CountryRLM: RLMModel {
    
     @objc dynamic var name = ""
     @objc dynamic var capital = ""
    
    convenience init(name: String, capital: String) {
        self.init()
        self.name = name
        self.capital = capital
    }
    
    convenience init(_ country: Country) {
        self.init(name: country.name, capital: country.capital)
    }
}

public class WeatherRLM: RLMModel {

    @objc dynamic var temperature = 0.0
    @objc dynamic var date = Date()
    
    convenience init(date: Date, temperature: Double) {
        self.init()
        self.temperature = temperature
        self.date = date
    }
    
//    convenience init(_ weather: Weather) {
//        self.init(date: weather.date, temperature: weather.temperature.)
//    }
}
