//
//  GameScene.swift
//  Space Cat
//
//  Created by Rishabh Parikh on 1/11/15.
//  Copyright (c) 2015 Rishabh Parikh. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameTitleScene: SKScene {
    
    var pressStartSound = SKAction.playSoundFileNamed("PressStart.caf", waitForCompletion: false)
    var backgroundMusic: AVAudioPlayer = AVAudioPlayer(contentsOfURL: NSBundle.mainBundle().URLForResource("StartScreen", withExtension: "mp3"), error: nil)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let background : SKSpriteNode = SKSpriteNode(imageNamed:"splash_1")
        background.position = CGPoint(x: self.frame.minX, y: self.frame.minY)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(background)
        
        self.backgroundMusic.numberOfLoops = 1
        self.backgroundMusic.prepareToPlay()
        self.backgroundMusic.play()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        var gamePlayScene = GamePlayScene(fileNamed: "GamePlayScene")
        gamePlayScene.size = self.size
        let transition = SKTransition.fadeWithDuration(1.0)
        self.runAction(pressStartSound)
        self.backgroundMusic.stop()
        self.view?.presentScene(gamePlayScene, transition: transition)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
