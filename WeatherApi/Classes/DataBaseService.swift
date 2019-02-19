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
 
    public typealias ManagedObject = JSONCountryRLM
    
    //private let realm: Realm?
    
//    var realm: F.Execute<Realm?> = {
//        Realm.current
//    }
    
//    public init(realm: Realm?) {
//        self.realm = realm
//    }
    
    public func read() -> Results<JSONCountryRLM>? {
        return Realm.current?.objects(JSONCountryRLM.self)
    }
    
    public func read(id: String) -> JSONCountryRLM? {
        return Realm.current?.object(ofType: JSONCountryRLM.self, forPrimaryKey: id)
    }
    
    public func write(object: JSONCountryRLM) {
        Realm.write {
            $0.add(object, update: true)
        }
    }
}

public class WeatherDataRealm: StorageProtocol {
    
    public typealias ManagedObject = JSONWeatherRLM
    
    private let realm: Realm?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    public func read(id: String) -> JSONWeatherRLM? {
        return self.realm?.object(ofType: JSONWeatherRLM.self, forPrimaryKey: id)
    }
    
    public func write(object: JSONWeatherRLM) {
        try? self.realm?.write {
            self.realm?.add(object, update: true)
        }
    }
}

public protocol StorageProtocol {
    
    associatedtype ManagedObject
    
    func write(object: ManagedObject)
    
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

public class JSONCountryRLM: RLMModel {
    
     @objc dynamic var name = ""
     @objc dynamic var capital = ""
    
    convenience init(name: String, capital: String, id: String) {
        self.init()
        self.id = id
        self.name = name
        self.capital = capital
    }
    
    convenience init(_ json: JSONCountry) {
        self.init(name: json.name, capital: json.capital, id: json.alpha2Code)
    }
}

public class JSONWeatherRLM: RLMModel {

    @objc dynamic var temperature = 0.0
    @objc dynamic var date = 0
    
    convenience init(date: Int, temperature: Double, id: String) {
        self.init()
        self.id = id
        self.temperature = temperature
        self.date = date
    }
    
    convenience init(_ json: JSONWeather) {
        self.init(date: json.dt, temperature: json.main.temp, id: json.sys.country)
    }
}
