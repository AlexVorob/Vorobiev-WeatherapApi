//
//  CGRect+Extensions.swift
//  UI Task
//
//  Created by Alex Vorobiev on 12/28/18.
//  Copyright © 2018 Student. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    public enum Position {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case leftCenter
        case rightCenter
        case center
        case topCenter
        case bottomCenter
    }
    
    var topLeft: CGPoint {
        return CGPoint(x: self.minX, y: self.minY)
    }
    
    var topRight: CGPoint {
        return CGPoint(x: self.maxX, y: self.minY)
    }
    
    var bottomRight: CGPoint {
        return CGPoint(x: self.maxX, y: self.maxY)
    }
    
    var bottomLeft: CGPoint {
        return CGPoint(x: self.minX, y: self.maxY)
    }
    
    var leftCenter: CGPoint {
        return CGPoint(x: self.minX, y: self.midY)
    }
    
    var rightCenter: CGPoint {
        return CGPoint(x: self.maxX, y: self.midY)
    }
    
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
    
    var topCenter: CGPoint {
        return CGPoint(x: self.midX, y: self.minY)
    }
    
    var bottomCenter: CGPoint {
        return CGPoint(x: self.midX, y: self.maxY)
    }
    
    public func point(at position: Position) -> CGPoint {
        switch position {
        case .topLeft: return self.topLeft
        case .topRight: return self.topRight
        case .bottomLeft: return self.bottomLeft
        case .bottomRight: return self.bottomRight
        case .leftCenter: return self.leftCenter
        case .rightCenter: return self.rightCenter
        case .center: return self.center
        case .topCenter: return self.topCenter
        case .bottomCenter: return self.bottomCenter
        }
    }
}
