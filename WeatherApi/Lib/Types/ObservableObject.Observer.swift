//
//  ObservableObject+Extentions.swift
//  WeatherApi
//
//  Created by Student on 12/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension ObservableObject {
    
    public class Observer: Hashable, Cancellable {
        
        public var isObserving: Bool {
            return self.sender != nil
        }
        
        public var isCancelled: Bool {
            return !self.isObserving
        }
        
        public var hashValue: Int {
            return ObjectIdentifier(self).hashValue
        }
        
        private(set) var handler: Handler
        
        private weak var sender: ObservableObject?
        
        public init(sender: ObservableObject, handler: @escaping Handler) {
            self.sender = sender
            self.handler = handler
        }
        
        public func cancel() {
            self.sender = nil
        }
        
        public static func == (lhs: Observer, rhs: Observer) -> Bool {
            return lhs === rhs
        }
    }
}
