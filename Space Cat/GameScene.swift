//
//  GameScene.swift
//  Space Cat
//
//  Created by Rishabh Parikh on 1/11/15.
//  Copyright (c) 2015 Rishabh Parikh. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 14;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        
        let greenNode = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 10, height: 100))
        greenNode.anchorPoint = CGPoint(x: 0, y: 0)
        greenNode.position = CGPoint(x: 10, y: 10)
        self.addChild(greenNode)
        
        let redNode = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 100, height: 10))
        redNode.anchorPoint = CGPoint(x: 0, y: 0)
        redNode.position = CGPoint(x: 10, y: 10)
        self.addChild(redNode)
        

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            println("\(location.x),\(location.y)")
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
