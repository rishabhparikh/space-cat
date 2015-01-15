//
//  GamePlayScene.swift
//  Space Cat
//
//  Created by Rishabh Parikh on 1/11/15.
//  Copyright (c) 2015 Rishabh Parikh. All rights reserved.
//

import SpriteKit
import Foundation
import AVFoundation

class GamePlayScene: SKScene, SKPhysicsContactDelegate {

    var lastUpdateTimeInterval: NSTimeInterval?
    var timeSinceEnemyAdded: NSTimeInterval?
    var totalGameTime: NSTimeInterval?
    var minSpeed: Int?
    var addEnemyTimeInterval: NSTimeInterval?
    var maxSpeed: Int?
    var damageSound = SKAction.playSoundFileNamed("Damage.caf", waitForCompletion: false)
    var explodeSound = SKAction.playSoundFileNamed("Explode.caf", waitForCompletion: false)
    var laserSound = SKAction.playSoundFileNamed("Laser.caf", waitForCompletion: false)
    var gameplayMusic: AVAudioPlayer = AVAudioPlayer(contentsOfURL: NSBundle.mainBundle().URLForResource("Gameplay", withExtension: "mp3"), error: nil)
    var gameOverMusic: AVAudioPlayer = AVAudioPlayer(contentsOfURL: NSBundle.mainBundle().URLForResource("GameOver", withExtension: "mp3"), error: nil)
    var gameOver: Bool?
    var gameOverDisplayed: Bool?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.gameOver = false
        self.gameOverDisplayed = false
        
        let background : SKSpriteNode = SKSpriteNode(imageNamed:"background_1")
        background.position = CGPoint(x: self.frame.minX, y: self.frame.minY)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(background)
        
        var machine = MachineNode(machineAtPosition: CGPoint(x: self.frame.midX, y: 12))
        machine.zPosition = 8
        self.addChild(machine)
        
        var spaceCat = SpaceCatNode(catAtPosition: CGPoint(x: machine.position.x, y: machine.position.y-2))
        spaceCat.zPosition = 9
        self.addChild(spaceCat)
        
        self.physicsWorld.contactDelegate = self;
        var ground = GroundNode(size: CGSizeMake(self.frame.size.width, 22))
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.addChild(ground)
        
        self.lastUpdateTimeInterval = 0;
        self.timeSinceEnemyAdded = 0
        self.totalGameTime = 0;
        self.minSpeed = Int(Util.SPACEDOG_MIN_SPEED)
        self.maxSpeed = Int(Util.SPACEDOG_MAX_SPEED)
        self.addEnemyTimeInterval = 1.5;
        
        self.gameplayMusic.numberOfLoops = 1
        self.gameplayMusic.prepareToPlay()
        self.gameplayMusic.play()
        
        self.gameOverMusic.numberOfLoops = 1
        self.gameOverMusic.prepareToPlay()
        
        var hudNode = HUDNode(hudAtPosition: CGPointMake(0, self.frame.size.height-20), frame: self.frame)
        hudNode.name = "HUD"
        self.addChild(hudNode)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        if(!gameOver!) {
            (self.childNodeWithName("SpaceCat") as SpaceCatNode).performTap()
            
            for touch: AnyObject in touches {
                shootProjectileTowardsPosition(touch.locationInNode(self))
            }
        }
        else {
            self.gameOverMusic.stop()
            self.removeAllChildren()
            var gamePlayScene = GamePlayScene(fileNamed: "GamePlayScene")
            gamePlayScene.size = self.size
            let transition = SKTransition.fadeWithDuration(1.0)
            self.view?.presentScene(gamePlayScene, transition: transition)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.timeSinceEnemyAdded! += currentTime - self.lastUpdateTimeInterval!
        
        if(self.timeSinceEnemyAdded > addEnemyTimeInterval! && !gameOver!) {
            addSpaceDog()
            self.timeSinceEnemyAdded = 0
            self.totalGameTime! += addEnemyTimeInterval!
        }

        self.lastUpdateTimeInterval = currentTime

        if self.totalGameTime > 40 {
            self.addEnemyTimeInterval = 0.5;
            self.minSpeed = 150;
        } else if self.totalGameTime > 30 {
            self.addEnemyTimeInterval = 0.65
            self.minSpeed = 125;
        } else if self.totalGameTime > 20 {
            self.addEnemyTimeInterval = 0.75
            self.minSpeed = 100
        } else if self.totalGameTime > 10 {
            self.addEnemyTimeInterval = 1.00
            self.minSpeed = 75
        }
        else {
            self.addEnemyTimeInterval = 1.5
            self.minSpeed = 50
        }
        
        if(self.gameOver! && !gameOverDisplayed!) {
            self.performGameOver()
            gameOverDisplayed = true
        }
    }
    
    func performGameOver() {
        var gameOver = GameOverNode(atPosition: CGPointMake(self.frame.midX, self.frame.midY))
        self.addChild(gameOver)
        gameOver.performAnimation()
        self.gameplayMusic.stop()
        self.gameOverMusic.play()
    }
    
    func addSpaceDog() {
        self.maxSpeed = self.minSpeed! + 50
        var randomBinary = Util.randomNumberWithinRange(0, max: 2)
        var spaceDogNode: SpaceDogNode
        if(randomBinary == 0) {
            spaceDogNode = SpaceDogNode(spaceDogType: SpaceDogType.SpaceDogTypeA)
        }
        else {
            spaceDogNode = SpaceDogNode(spaceDogType: SpaceDogType.SpaceDogTypeB)
        }
        
        spaceDogNode.position = CGPoint(x: Util.randomNumberWithinRange(UInt32(spaceDogNode.size.width) + 10,
            max: UInt32(self.frame.size.width - spaceDogNode.size.width - 10)), y: Int(self.frame.size.height + spaceDogNode.size.height))
        spaceDogNode.physicsBody?.velocity = CGVector(dx: 0, dy: -Util.randomNumberWithinRange(UInt32(minSpeed!), max: UInt32(maxSpeed!)))
        self.addChild(spaceDogNode)
    }
    
    func shootProjectileTowardsPosition(position: CGPoint) {
        let projectile = ProjectileNode(projectileAtPosition: position)
        projectile.position = CGPoint(x: self.childNodeWithName("Machine")!.position.x,
                                      y: self.childNodeWithName("Machine")!.position.y
                                        + self.childNodeWithName("Machine")!.frame.size.height)
        
        self.addChild(projectile)
        self.runAction(laserSound)
        projectile.moveTowardsPosition(position)
    }
    
    func createDebrisAtPosition(position: CGPoint) {
        var numberOfPieces = Int(Util.randomNumberWithinRange(5, max: 20))
        for var i=0; i < numberOfPieces; i++ {
            var randomPiece = Util.randomNumberWithinRange(1, max: 4)
            var imageName = "debri_\(randomPiece)"
            var debris = SKSpriteNode(imageNamed: imageName)
            debris.position = position
            debris.zPosition = 6
            self.addChild(debris)
            
            debris.physicsBody = SKPhysicsBody(rectangleOfSize: debris.frame.size)
            debris.physicsBody?.categoryBitMask = CollisionCategory.Debris.rawValue
            debris.physicsBody?.contactTestBitMask = 0
            debris.physicsBody?.collisionBitMask = CollisionCategory.Ground.rawValue | CollisionCategory.Debris.rawValue
            debris.name = "debris"
            
            var positive = Util.randomNumberWithinRange(0, max: 2)
            if positive == 0 {
                debris.physicsBody?.velocity = CGVector(dx: Util.randomNumberWithinRange(0, max: 150), dy: Util.randomNumberWithinRange(150, max: 350))
            }
            else {
                debris.physicsBody?.velocity = CGVector(dx: -Util.randomNumberWithinRange(0, max: 150), dy: Util.randomNumberWithinRange(150, max: 350))
            }
            
            debris.runAction(SKAction.waitForDuration(2), completion: { () -> Void in
                debris.removeFromParent()
            })
        }
        
        
        var explosionPath = NSBundle.mainBundle().pathForResource("Explosion", ofType: "sks")
        var explosion : SKEmitterNode = NSKeyedUnarchiver.unarchiveObjectWithFile(explosionPath!) as SKEmitterNode
        
        explosion.position = position
        explosion.zPosition = 1
        self.addChild(explosion)
        
        explosion.runAction(SKAction.waitForDuration(2), completion: { () -> Void in
            explosion.removeFromParent()
        })
        
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody, secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == CollisionCategory.Enemy.rawValue && secondBody.categoryBitMask == CollisionCategory.Projectile.rawValue {
            (secondBody.node as ProjectileNode).removeFromParent()
            self.runAction(explodeSound)
            
            (firstBody.node as SpaceDogNode).health -= 1
            
            if((firstBody.node as SpaceDogNode).health == -1) {
                
                self.createDebrisAtPosition(contact.contactPoint)
                (self.childNodeWithName("HUD") as HUDNode).addPoints(50)
            }
            
            (firstBody.node as SpaceDogNode).checkHealth()
        }
        else if firstBody.categoryBitMask == CollisionCategory.Enemy.rawValue && secondBody.categoryBitMask == CollisionCategory.Ground.rawValue {
            (firstBody.node as SpaceDogNode).removeFromParent()
            self.createDebrisAtPosition(contact.contactPoint)
            self.runAction(damageSound)
            var hudNode = (self.childNodeWithName("HUD") as HUDNode)
            hudNode.childNodeWithName("Life\(hudNode.getLives())")?.removeFromParent()
            hudNode.removeLife()
            if(hudNode.getLives() == 0) {
                self.gameOver = true
            }
        }
    }
}
