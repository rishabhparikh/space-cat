//
//  MachineNode.swift
//  Space Cat
//
//  Created by Rishabh Parikh on 1/11/15.
//  Copyright (c) 2015 Rishabh Parikh. All rights reserved.
//

import SpriteKit

class MachineNode: SKSpriteNode {
    
    let textures: [SKTexture] = [SKTexture(imageNamed: "machine_1"), SKTexture(imageNamed: "machine_2")]
    let machineAnimation: SKAction
    let machineRepeat: SKAction
    
    init(machineAtPosition: CGPoint) {
        
        machineAnimation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        machineRepeat = SKAction.repeatActionForever(machineAnimation)
        
        var texture = SKTexture(imageNamed: "machine_1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.position = machineAtPosition
        self.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.runAction(machineRepeat)
        self.name = "Machine"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
