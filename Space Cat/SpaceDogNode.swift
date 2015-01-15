//
//  SpaceDog.swift
//  Space Cat
//
//  Created by Rishabh Parikh on 1/12/15.
//  Copyright (c) 2015 Rishabh Parikh. All rights reserved.
//

import SpriteKit

enum SpaceDogType: Int {
    case SpaceDogTypeA = 0
    case SpaceDogTypeB = 1
}

class SpaceDogNode: SKSpriteNode {
    var texturesA: [SKTexture]
    var texturesB: [SKTexture]
    var health = 1
    var spaceDogType: SpaceDogType
    
    func checkHealth() {
        if(self.health == 0) {
            if(self.spaceDogType == SpaceDogType.SpaceDogTypeA) {
                self.texture = SKTexture(imageNamed: "spacedog_A_3")
                self.removeActionForKey("AnimationA")
            }
            else {
                self.texture = SKTexture(imageNamed: "spacedog_B_4")
                self.removeActionForKey("AnimationB")
            }
        } else if self.health < 0 {
            self.removeFromParent()
        }
    }
    
    init(dogAtPosition: CGPoint, spaceDogType: SpaceDogType) {
   
        var texture: SKTexture
        
        texturesA = [SKTexture(imageNamed: "spacedog_A_1"), SKTexture(imageNamed: "spacedog_A_2")]
        texturesB = [SKTexture(imageNamed: "spacedog_B_1"), SKTexture(imageNamed: "spacedog_B_2"),
                     SKTexture(imageNamed: "spacedog_B_3")]
        
        var dogAnimationA = SKAction.animateWithTextures(texturesA, timePerFrame: 0.1)
        var dogAnimationB = SKAction.animateWithTextures(texturesB, timePerFrame: 0.1)
        
        if spaceDogType == SpaceDogType.SpaceDogTypeA {
            self.spaceDogType = SpaceDogType.SpaceDogTypeA
            texture = SKTexture(imageNamed: "spacedog_A_1")
            super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
            self.runAction(SKAction.repeatActionForever(dogAnimationA), withKey: "AnimationA")
        }
        else {
            self.spaceDogType = SpaceDogType.SpaceDogTypeB
            texture = SKTexture(imageNamed: "spacedog_B_1")
            super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
            self.runAction(SKAction.repeatActionForever(dogAnimationB), withKey: "AnimationB")
        }
        setupPhysicsBody()
        
        var scale: CGFloat = CGFloat(Util.randomNumberWithinRange(50, max: 101)) / 100.0
        self.xScale = scale
        self.yScale = scale
        
        self.position = dogAtPosition
    }
    
    init(spaceDogType: SpaceDogType) {
        var texture: SKTexture
        
        texturesA = [SKTexture(imageNamed: "spacedog_A_1"), SKTexture(imageNamed: "spacedog_A_2")]
        texturesB = [SKTexture(imageNamed: "spacedog_B_1"), SKTexture(imageNamed: "spacedog_B_2"),
                     SKTexture(imageNamed: "spacedog_B_3")]
        
        var dogAnimationA = SKAction.animateWithTextures(texturesA, timePerFrame: 0.1)
        var dogAnimationB = SKAction.animateWithTextures(texturesB, timePerFrame: 0.1)
        
        if spaceDogType == SpaceDogType.SpaceDogTypeA {
            self.spaceDogType = SpaceDogType.SpaceDogTypeA
            texture = SKTexture(imageNamed: "spacedog_A_1")
            super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
            self.runAction(SKAction.repeatActionForever(dogAnimationA), withKey: "AnimationA")
        }
        else {
            self.spaceDogType = SpaceDogType.SpaceDogTypeB
            texture = SKTexture(imageNamed: "spacedog_B_1")
            super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
            self.runAction(SKAction.repeatActionForever(dogAnimationB), withKey: "AnimationB")
        }
        setupPhysicsBody()
        var scale: CGFloat = CGFloat(Util.randomNumberWithinRange(50, max: 101)) / 100.0
        self.xScale = scale
        self.yScale = scale
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.velocity = CGVectorMake(0, -50)
        self.physicsBody?.categoryBitMask = CollisionCategory.Enemy.rawValue
        self.physicsBody?.collisionBitMask = 0;
        self.physicsBody?.contactTestBitMask = CollisionCategory.Projectile.rawValue | CollisionCategory.Ground.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
