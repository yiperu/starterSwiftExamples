//
//  GameScene.swift
//  FlappyBird
//
//  Created by Henry Antonio Ambicho Trujillo on 8/7/14.
//  Copyright (c) 2014 Apps4s. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode();
    var skyColor = SKColor();
    // varible para el pipe
    var verticalPipeGap = 130.0
    //---
    var pipeTexture1 = SKTexture();
    var pipeTexture2 = SKTexture();
    var movePipesAndRemove = SKAction()
    
    let birdCategory:UInt32 = 1 << 0
    let wordCategory:UInt32 = 1 << 1
    let pipeCategory:UInt32 = 1 << 2
    
    var moving = SKNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        // IMplementaremos la caida del ave cuando exista alguna colision
        self.addChild(moving)
        
        // ----- Esto genera una gravedad a  (mfe)
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.0)
        // -- para el efecto de lus de fondo
        self.physicsWorld.contactDelegate = self
        
        
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
        
        bird.physicsBody.categoryBitMask = birdCategory
        bird.physicsBody.collisionBitMask = wordCategory | pipeCategory
        bird.physicsBody.contactTestBitMask = wordCategory | pipeCategory
        
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
            //self.addChild(sprite)
            moving.addChild(sprite)
        }
        
        // Generamos el piso para que el ave no se desaparesca cuando caiga
        var dummy = SKNode()
        dummy.position = CGPointMake(0, groundTexture.size().height / 2)
        dummy.physicsBody = SKPhysicsBody(rectangleOfSize:CGSizeMake(self.frame.size.width, groundTexture.size().height))
        dummy.physicsBody.dynamic = false
        dummy.physicsBody.categoryBitMask = wordCategory
        
        self.addChild(dummy)
        
        
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
            // self.addChild(sprite)  // Cambiado para la el efecto de caida
            moving.addChild(sprite)
        }
        
        // Implementamos aqui lo Pipes:
        // var verticalPipeGap = 130.0
        
        pipeTexture1 = SKTexture(imageNamed:"Pipe1");
        pipeTexture1.filteringMode = SKTextureFilteringMode.Nearest
        pipeTexture2 = SKTexture(imageNamed:"Pipe2");
        pipeTexture2.filteringMode = SKTextureFilteringMode.Nearest
        

        
        var distanceToMove = CGFloat(self.frame.size.width + 2.0 * pipeTexture1.size().width)
        var movePipes = SKAction.moveByX(-distanceToMove, y: 0.0, duration: NSTimeInterval(0.01 * distanceToMove))
        // Trabajamos los pipes
        var removePipes = SKAction.removeFromParent()
        //moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])  // Creo que esto esta mal
        movePipesAndRemove = SKAction.sequence([movePipes, removePipes])
        
        var spawn = SKAction.runBlock({() in self.spawnPipes()})
        var delay = SKAction.waitForDuration(NSTimeInterval(2.0))
        var spawnThenDelay = SKAction.sequence([spawn, delay])
        var spawnThenDelayForever = SKAction.repeatActionForever(spawnThenDelay)
        self.runAction(spawnThenDelayForever)
        
    }
    
    func spawnPipes(){
        
        var pipePair = SKNode()
        pipePair.position = CGPointMake(self.frame.size.width + pipeTexture1.size().width * 2.0, 0)
        pipePair.zPosition = -10
        
        var height = UInt32(self.frame.height / 3)
        var y = arc4random() % height
        
        var pipe1 = SKSpriteNode(texture: pipeTexture1)
        pipe1.position = CGPointMake(0.0, CGFloat(y))
        pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipe1.size)
        pipe1.physicsBody.dynamic = false
        pipe1.physicsBody.categoryBitMask = pipeCategory
        pipe1.physicsBody.contactTestBitMask = birdCategory
        pipePair.addChild(pipe1)
        
        var pipe2 = SKSpriteNode(texture: pipeTexture2)
        pipe2.position = CGPointMake(0.0, CGFloat(y) + pipe1.size.height + CGFloat(verticalPipeGap))
        pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipe2.size)
        pipe2.physicsBody.dynamic = false
        pipe2.physicsBody.categoryBitMask = pipeCategory
        pipe2.physicsBody.contactTestBitMask = birdCategory
        pipePair.addChild(pipe2)
        
        // pipePair.runAction(moveAndRemovePipes) // Creo que esto esta mal
        pipePair.runAction(movePipesAndRemove)
        //self.addChild(pipePair)
        moving.addChild(pipePair)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        // Aqui controla mos los otuch en el screeen
        bird.physicsBody.velocity = CGVectorMake(0, 0)
        bird.physicsBody.applyImpulse(CGVectorMake(0, 8))
        
        
    }
   
    // Implementaremos la rotacion del ave cuando se eleve, para esto tenemos que implementar una funcion que devuelva el max o min valor
    
    func clamp (min: CGFloat, max: CGFloat, value: CGFloat) -> CGFloat {
        if(value  > max){
            return max
        } else if (value < min) {
            return min
        } else {
            return value
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        // Aqui implementamos la rotacion en si:
        bird.zRotation = self.clamp(-1, max: 0.5, value: bird.physicsBody.velocity.dy * (bird.physicsBody.velocity.dy < 0 ? 0.003 : 0.001))
    }
    
    // Ahora implementamos el contex notificacion delegate
    func didBeginContact (contact: SKPhysicsContact!){
        
        if(moving.speed > 0){
            moving.speed = 0
            
            self.removeActionForKey("flash")
            var turnBackgroundRed = SKAction.runBlock({() in self.setBackgroundRed()})
            var wait = SKAction.waitForDuration(0.05)
            var turnBackgroundWhite = SKAction.runBlock({() in self.setBackgroundWhite()})
            var turnBackgroundColorSky = SKAction.runBlock({() in self.setBackgroundColorSky()})
            
            // Implementamos el efecto del explosion de fondo con luces
            var sequenceOfActions = SKAction.sequence([turnBackgroundRed, wait, turnBackgroundWhite, wait, turnBackgroundColorSky])
            var repeatSequence = SKAction.repeatAction(sequenceOfActions, count: 4)
            self.runAction(repeatSequence, withKey: "flash")
        }
    
    }
    
    func setBackgroundRed(){
        self.backgroundColor = UIColor.redColor()
    }
    
    func setBackgroundWhite(){
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func setBackgroundColorSky(){
        self.backgroundColor = SKColor(red:113.0/255.0, green: 197.0/255.0, blue:207.0/255.0, alpha: 1.0)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
