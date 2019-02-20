//
//  DataBaseService.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/18/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import RealmSwift

protocol StorageProvider {
    
    associatedtype ManagedObject
    associatedtype Storage
    
    func read(id: String) -> ManagedObject?
    func read() -> [ManagedObject]?
    func write(storage: ManagedObject)
}

class DataBaseService<Provider: StorageProvider> {
    
    public let value: Provider
    
    init(provider: Provider) {
        self.value = provider
    }
}

class DataRealm<StorageType: Object>: StorageProvider
    where StorageType: RealmModelSerializable
{
    
    typealias Storage = StorageType
    typealias ManagedObject = StorageType.ConvertableType
    
    open func read(id: String) -> ManagedObject? {
        let values = Realm.current?.object(ofType: StorageType.self, forPrimaryKey: id)
        
        return values.map { $0.converted() }
    }
    
    open func read() -> [ManagedObject]? {
        let results = Realm.current?.objects(StorageType.self)
        
        return results.map { $0.map { $0.converted() } }
    }
    
    open func write(storage: ManagedObject) {
        Realm.write {
            let value = Storage(json: storage)
            
            $0.add(value, update: true)
        }
    }
}

class CountryRLM: DataRealm<JSONCountryRLM> { }

class WeatherRLM: DataRealm<JSONWeatherRLM> { }

protocol RealmModelSerializable {
    
    associatedtype ConvertableType
    
    init(json: ConvertableType)
    
    func converted() -> ConvertableType
}

class JSONWeatherRLM: RLMModel, RealmModelSerializable {
    
    @objc dynamic var temperature = 0.0
    
    @objc dynamic var dt = 0
    
    convenience init(id: String, temperature: Double, date: Int) {
        self.init()
        self.id = id
        self.temperature = temperature
        self.dt = date
    }
    
    required convenience init(json: JSONWeather) {
        self.init(id: json.sys.country, temperature: json.main.temp, date: json.dt)
    }
    
    func converted() -> JSONWeather {
        let id = JSONWeather.Sys(country: self.id)
        let main = JSONWeather.Main(temp: self.temperature)
        
        return JSONWeather(dt: self.dt, main: main, sys: id)
    }
}

class JSONCountryRLM: RLMModel, RealmModelSerializable {
    
    @objc dynamic var name = ""
    
    @objc dynamic var capital = ""
    
    convenience init(id: String, name: String, capital: String) {
        self.init()
        self.id = id
        self.name = name
        self.capital = capital
    }
    
    required convenience init(json: JSONCountry) {
        self.init(id: json.alpha2Code, name: json.name, capital: json.capital)
    }
    
    func converted() -> JSONCountry {
        return JSONCountry(name: self.name, capital: self.capital, alpha2Code: self.id)
    }
}

public class RLMModel: Object {
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id = ""
}
