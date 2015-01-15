//
//  ProjectileNode.swift
//  Space Cat
//
//  Created by Rishabh Parikh on 1/11/15.
//  Copyright (c) 2015 Rishabh Parikh. All rights reserved.
//

import SpriteKit

class ProjectileNode: SKSpriteNode {
    
    let textures: [SKTexture] = [SKTexture(imageNamed: "projectile_1"), SKTexture(imageNamed: "projectile_2"), SKTexture(imageNamed: "projectile_3")]
    let machineAnimation: SKAction
    let machineRepeat: SKAction

    init(projectileAtPosition: CGPoint) {
        
        machineAnimation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        machineRepeat = SKAction.repeatActionForever(machineAnimation)
        var texture = SKTexture(imageNamed: "machine_1")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 20, height: 20))
        self.runAction(machineRepeat)
        self.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        self.position = projectileAtPosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveTowardsPosition(position: CGPoint) {
        // y2 = m(x3-x1) + y1
        var y1: CGFloat, y3: CGFloat, x1: CGFloat,
            x3: CGFloat, m: CGFloat, y2: CGFloat,
            x2: CGFloat?, a: CGFloat, b: CGFloat,
            c:CGFloat, time: NSTimeInterval
        
        y3 = position.y
        y1 = self.position.y
        
        x3 = position.x
        x1 = self.position.x
        
        m = (y3-y1)/(x3-x1)
        
        if(position.x <= self.position.x) {
            x2 = -10
        }
        else {
            x2 = self.parent!.frame.size.width + 10
        }
        
        y2 = m * (x2!-x1) + y1
        
        a = y2-y1
        b = x2!-x1
        c = sqrt(pow(a, 2) + pow(b, 2))
        
        time = Double(c / Util.PROJECTILE_SPEED)
        
        let moveProjectile: SKAction = SKAction.moveTo(CGPoint(x:x2!,y:y2), duration: time)
        self.runAction(moveProjectile)
        var seqAction = SKAction.sequence([SKAction.waitForDuration(time * 0.75) ,SKAction.fadeOutWithDuration(time * 0.25)])
        self.runAction(seqAction)
        setupPhysicsBody()
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionCategory.Projectile.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionCategory.Enemy.rawValue
    }
}
