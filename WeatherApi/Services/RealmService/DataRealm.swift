//
//  DataRealm.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import RealmSwift

fileprivate let providerID = autoIncrementedID(0)

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
