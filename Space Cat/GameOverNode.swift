 //
//  GameOverNode.swift
//  Space Cat
//
//  Created by Rishabh Parikh on 1/14/15.
//  Copyright (c) 2015 Rishabh Parikh. All rights reserved.
//

import SpriteKit
 
 class GameOverNode: SKNode {
    init(atPosition: CGPoint) {
        super.init()
        var gameOverLabel: SKLabelNode = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        gameOverLabel.name = "GameOver"
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 48
        gameOverLabel.position = atPosition
        self.addChild(gameOverLabel)
    }
    
    func performAnimation() {
        var label = self.childNodeWithName("GameOver")
        label?.xScale = 0
        label?.yScale = 0
        var scaleUp = SKAction.scaleTo(1.2, duration: 0.75)
        var scaleDown = SKAction.scaleTo(0.9, duration: 0.25)
        var labelChange = SKAction.runBlock { () -> Void in
            var restartLabel = SKLabelNode(text: "Touch To Restart")
            restartLabel.fontName = "Futura-CondensedExtraBold"
            restartLabel.fontSize = 24
            restartLabel.position = CGPointMake(label!.position.x, label!.position.y-40)
            self.addChild(restartLabel)
        }
        var scale = SKAction.sequence([scaleUp,scaleDown,labelChange])
        label?.runAction(scale)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 }
