//
//  SpaceCat.swift
//  Space Cat
//
//  Created by Rishabh Parikh on 1/11/15.
//  Copyright (c) 2015 Rishabh Parikh. All rights reserved.
//

import SpriteKit

class SpaceCatNode: SKSpriteNode {
    
    let textures: [SKTexture] = [SKTexture(imageNamed: "spacecat_2"), SKTexture(imageNamed: "spacecat_1")]
    let tapAction: SKAction

    init(catAtPosition: CGPoint) {
        
        tapAction = SKAction.animateWithTextures(textures, timePerFrame: 0.25)
        
        var texture = SKTexture(imageNamed: "spacecat_1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.position = catAtPosition
        self.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.runAction(tapAction)
        self.name = "SpaceCat"
    }
    
    func performTap() {
        self.runAction(tapAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}