//
//  GameScene.swift
//  FlappyBird
//
//  Created by Henry Antonio Ambicho Trujillo on 8/7/14.
//  Copyright (c) 2014 Apps4s. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var bird = SKSpriteNode();
    var skyColor = SKColor();
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        skyColor = SKColor(red:113.0/255.0, green: 197.0/255.0, blue:207.0/255.0, alpha: 1.0);
        self.backgroundColor = skyColor;
        
        var birdTexture1 = SKTexture(imageNamed:"Bird1");
        birdTexture1.filteringMode = SKTextureFilteringMode.Nearest
        var birdTexture2 = SKTexture(imageNamed:"Bird2");
        birdTexture2.filteringMode = SKTextureFilteringMode.Nearest
        
        var animation = SKAction.animateWithTextures([birdTexture1, birdTexture2], timePerFrame: 0.2)
        var flap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture:birdTexture1)
        bird.position = CGPoint(x:self.frame.size.width / 2.0, y:CGRectGetMidY(self.frame))
        bird.runAction(flap)
        
        // Haremos que el pajaro caiga
        bird.physicsBody = SKPhysicsBody(circleOfRadius:bird.size.height / 2.0)
        bird.physicsBody.dynamic = true
        bird.physicsBody.allowsRotation =  false
        
        self.addChild(bird)
        
        // Creamos la parte del piso
        var groundTexture = SKTexture(imageNamed:"Ground")
        groundTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        // HAremos que el fondo simule movimiento del los edificios:
        var moveGroundSprite = SKAction.moveByX(-groundTexture.size().width, y: 0, duration: NSTimeInterval(0.01 * groundTexture.size().width))
        var resetGroundSprite = SKAction.moveByX(groundTexture.size().width, y: 0, duration: 0.0)
        var moveGroundSpritesForever = SKAction.repeatActionForever(SKAction.sequence([moveGroundSprite, resetGroundSprite]))
        
        
        for var i:CGFloat = 0; i < 2 + self.frame.size.width / (groundTexture.size().width);++i {
            var sprite = SKSpriteNode(texture: groundTexture)
            sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2)
            sprite.runAction(moveGroundSpritesForever)
            self.addChild(sprite)
        }
        
        // Creamos la parte de fondo que se ve a lo lejos
        var skylineTexture = SKTexture(imageNamed:"Skyline")
        skylineTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        // HAremos que el fondo simule movimiento del Cielo:
        var moveSkylineSprite = SKAction.moveByX(-skylineTexture.size().width, y: 0, duration: NSTimeInterval(0.01 * skylineTexture.size().width))
        var resetSkylineSprite = SKAction.moveByX(skylineTexture.size().width, y: 0, duration: 0.0)
        var moveSkylineSpritesForever = SKAction.repeatActionForever(SKAction.sequence([moveSkylineSprite, resetSkylineSprite]))
        
        for var i:CGFloat = 0; i < 2 + self.frame.size.width / (skylineTexture.size().width);++i {
            var sprite = SKSpriteNode(texture: skylineTexture)
            sprite.zPosition = -20
            sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2 + groundTexture.size().height)
            sprite.runAction(moveSkylineSpritesForever)
            self.addChild(sprite)
        }

        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        

        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
