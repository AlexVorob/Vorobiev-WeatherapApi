//
//  DataBaseService.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/18/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import RealmSwift

public class DataBaseService<Service: RLMModel>: StorageProtocol {

    public func read() -> Results<Service>? {
        return Realm.current?.objects(Service.self)
    }
    
    public func read(id: String) -> Service? {
        return Realm.current?.object(ofType: Service.self, forPrimaryKey: id)
    }
    
    public func write(object: Service) {
        Realm.write {
            $0.add(object, update: true)
        }
    }
}

//public class CountryDataRealm: StorageProtocol {
// 
//    public typealias ManagedObject = JSONCountryRLM
//    
//    public func read() -> Results<JSONCountryRLM>? {
//        return Realm.current?.objects(JSONCountryRLM.self)
//    }
//    
//    public func read(id: String) -> JSONCountryRLM? {
//        return Realm.current?.object(ofType: JSONCountryRLM.self, forPrimaryKey: id)
//    }
//    
//    public func write(object: JSONCountryRLM) {
//        Realm.write {
//            $0.add(object, update: true)
//        }
//    }
//}
//
//public class WeatherDataRealm: StorageProtocol {
//   
//    public typealias ManagedObject = JSONWeatherRLM
//
//    public func read(id: String) -> JSONWeatherRLM? {
//        return Realm.current?.object(ofType: JSONWeatherRLM.self, forPrimaryKey: id)
//    }
//    
//    public func read() -> Results<JSONWeatherRLM>? {
//        return Realm.current?.objects(JSONWeatherRLM.self)
//    }
//    
//    public func write(object: JSONWeatherRLM) {
//        Realm.write {
//            $0.add(object, update: true)
//        }
//    }
//}

public protocol StorageProtocol {
    
    associatedtype ManagedObject
    associatedtype Collection: RealmCollection where Collection.ElementType == ManagedObject
    
    func write(object: ManagedObject)
    
    func read(id: String) -> ManagedObject?
    
    func read() -> Collection?
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
