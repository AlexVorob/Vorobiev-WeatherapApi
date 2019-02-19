//
//  ObservableObject.swift
//  WeatherApi
//
//  Created by Student on 12/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

public class ObservableObject<State> {
    
    public typealias Handler = (State) -> ()
    
    private let atomicObservers = Atomic([Observer]())
    
    @discardableResult
    public func observer(handler: @escaping Handler) -> Observer {
        return self.atomicObservers.modify {
            let observer = Observer(sender: self, handler: handler)
            $0.append(observer)
            
            return observer
        }
    }
    
    public func notify(_ state: State) {
        self.atomicObservers.modify {
            $0 = $0.filter { $0.isObserving }
            $0.forEach { $0.handler(state) }
        }
    }
}
