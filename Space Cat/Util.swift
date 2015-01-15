//
//  Util.swift
//  Space Cat
//
//  Created by Rishabh Parikh on 1/12/15.
//  Copyright (c) 2015 Rishabh Parikh. All rights reserved.
//

import Foundation
import SpriteKit

struct Util {
    static let PROJECTILE_SPEED: CGFloat = 400
    static let SPACEDOG_MIN_SPEED: UInt32  = 50
    static let SPACEDOG_MAX_SPEED: UInt32 = 100
    static let SPACECAT_MAX_LIVES: Int = 3
    
    static func randomNumberWithinRange(min: UInt32, max: UInt32) -> Int {
        return Int(arc4random()%(max - min) + min)
    }
}

enum CollisionCategory : UInt32 {
    case Enemy = 0001
    case Projectile = 0010
    case Debris = 0100
    case Ground = 1000
}

