//
//  GroundNode.swift
//  Space Cat
//
//  Created by Rishabh Parikh on 1/12/15.
//  Copyright (c) 2015 Rishabh Parikh. All rights reserved.
//

import Foundation
import SpriteKit

class GroundNode: SKSpriteNode {
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.clearColor(), size: size)
        self.name = "Ground"
        setUpPhysicsBody()
    }
    
    func setUpPhysicsBody(){
        self.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        self.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = CollisionCategory.Ground.rawValue
        self.physicsBody?.collisionBitMask = CollisionCategory.Debris.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.Enemy.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}