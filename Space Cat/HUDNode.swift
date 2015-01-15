//
//  HUDNode.swift
//  Space Cat
//
//  Created by Rishabh Parikh on 1/14/15.
//  Copyright (c) 2015 Rishabh Parikh. All rights reserved.
//

import SpriteKit

class HUDNode: SKNode {
    private var lives: Int
    private var points: Int
    
    init(hudAtPosition: CGPoint, frame: CGRect) {
        self.lives = Util.SPACECAT_MAX_LIVES
        self.points = 0;
        super.init()
        
        self.position = hudAtPosition
        self.zPosition = 10
        
        var catHead = SKSpriteNode(imageNamed: "HUD_cat_1")
        catHead.position = CGPointMake(30, -10)
        self.addChild(catHead)
        
        var lastLifeBar: SKSpriteNode?
        
        for(var i = 0; i < self.lives; i++) {
            var lifeBar: SKSpriteNode = SKSpriteNode(imageNamed: "HUD_life_1")
            lifeBar.name = "Life\(i+1)"
            self.addChild(lifeBar)
            
            if(lastLifeBar == nil) {
                lifeBar.position = CGPointMake(catHead.position.x + 30, catHead.position.y)
            }
            else {
                lifeBar.position = CGPointMake(lastLifeBar!.position.x + 10, lastLifeBar!.position.y)
            }

            lastLifeBar = lifeBar
        }
        var scoreLabel = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        scoreLabel.name = "Score"
        scoreLabel.text = "0"
        scoreLabel.fontSize = 24
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        scoreLabel.position = CGPointMake(frame.size.width - 20, -20)
        self.addChild(scoreLabel)

    }
    
    func addPoints(points: Int) {
        self.points += points
        (self.childNodeWithName("Score") as SKLabelNode).text = "\(self.points)"
    }
    
    func removeLife() {
        self.lives -= 1
    }
    
    func getLives() -> Int{
        return self.lives
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}