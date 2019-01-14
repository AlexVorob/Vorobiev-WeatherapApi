//
//  UIColor+Extensions.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/14/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init<T: SignedInteger>(red: T, green: T, blue: T, alpha: CGFloat) {
        let scale: (T) -> CGFloat = { CGFloat($0) / 255.0 }
        
        self.init(red: scale(red), green: scale(green), blue: scale(blue), alpha: alpha)
    }
    
    public enum Channel: UInt32 {
        case red = 3
        case green = 2
        case blue = 1
        case alpha = 0
    }
    
    public func channel(_ channel: Channel) -> CGFloat {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        switch channel {
        case .red: return r
        case.green: return g
        case .blue: return b
        case .alpha: return a
        }
    }
    
    public convenience init(rgb: UInt32) {
        self.init(rgba: (rgb << 8) | 0xFF)
    }
    
    public convenience init(rgba: UInt32) {
        let channel: (Channel) -> CGFloat = { CGFloat(rgba >> ($0.rawValue * 8) & 0xFF) / 255.0 }
        
        self.init(red: channel(.red), green: channel(.green), blue: channel(.blue), alpha: channel(.alpha))
    }
}
