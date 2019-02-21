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
    
    let providerID = autoIncrementedID(0)
    
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
            let value = Storage(object: storage)
            
            $0.add(value, update: true)
        }
    }
}

class CountryDataRLM: DataRealm<CountryRLM> { }

class WeatherDataRLM: DataRealm<WeatherRLM> { }

protocol RealmModelSerializable {
    
    associatedtype ConvertableType
    
    init(object: ConvertableType)
    
    func converted() -> ConvertableType
}

class WeatherRLM: RLMModel, RealmModelSerializable {
    
    @objc dynamic var temperature = 0.0
    @objc dynamic var date = Date()
    
    convenience init(id: String, temperature: Double, date: Date) {
        self.init()
        self.id = id
        self.temperature = temperature
        self.date = date
    }
    
    required convenience init(object: Weather) {
        self.init(id: object.id, temperature: object.temperature, date: object.date)
    }
    
    func converted() -> Weather {
        
        return Weather(date: self.date, temperature: self.temperature, id: self.id)
    }
}

class CountryRLM: RLMModel, RealmModelSerializable {
    
    @objc dynamic var name = ""
    @objc dynamic var capital = ""
    
    @objc dynamic var weather: WeatherRLM?
    
    convenience init(id: String, name: String, capital: String) {
        self.init()
        self.id = id
        self.name = name
        self.capital = capital
    }
    
    required convenience init(object: Country) {
        self.init(id: object.id, name: object.name, capital: object.capital)
    }
    
    func converted() -> Country {
        return Country(id: self.id, name: self.name, capital: self.capital)
    }
}

public class RLMModel: Object {
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id = ""
}


