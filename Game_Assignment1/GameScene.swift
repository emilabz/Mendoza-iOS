//
//  GameScene.swift
//  Game_Assignment1
//
//  Created by Emil Abraham Zachariah on 2020-02-06.
//  Copyright © 2020 Emil Abraham Zachariah. All rights reserved.
//

import SpriteKit
import GameplayKit

func +(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
func sqrt(a: CGFloat) -> CGFloat {
  return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint {
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
  
  func normalized() -> CGPoint {
    return self / length()
  }
}

class GameScene: SKScene {
    var monD=0
    var proD=0
    var background : SKSpriteNode = SKSpriteNode()
    init(size: CGSize, speed: Int) {
        super.init(size: size)
        switch speed {
        case 1:
            proD=1
            monD=4
            //2, 4
        case 2:
            proD=1
            monD=3
            //1 s, 2 s  pro:mon
        case 3:
            proD=1
            monD=2
            //1, 1
        default:
            proD=3
            monD=6
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct PhysicsCategory {
      static let none      : UInt32 = 0
      static let all       : UInt32 = UInt32.max
      static let monster   : UInt32 = 0b1       // 1
      static let projectile: UInt32 = 0b10      // 2
    }
    
    func random() -> CGFloat {
      return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
      return random() * (max - min) + min
    }
    
//    let player = SKSpriteNode(imageNamed: "player")
//    let player = SKSpriteNode(imageNamed: "down-1")
    var backgroundMusic: SKAudioNode!
    var hcount = 0;
    let player = SKSpriteNode(texture: SKTexture(imageNamed: "down-1"))
    let expl = SKSpriteNode(texture: SKTexture(imageNamed: "1"))
    let c1 = SKTexture(imageNamed: "down-1")
    let c2 = SKTexture(imageNamed: "down-2")
    let c3 = SKTexture(imageNamed: "down3")
    let c4 = SKTexture(imageNamed: "down-4")
    let c5 = SKTexture(imageNamed: "up-1")
    let c6 = SKTexture(imageNamed: "up-2")
    let c7 = SKTexture(imageNamed: "up-3")
    let c8 = SKTexture(imageNamed: "up-4")
    let e1=SKTexture(imageNamed: "1")
    let e2=SKTexture(imageNamed: "2")
    let e3=SKTexture(imageNamed: "3")
    let e4=SKTexture(imageNamed: "4")
    let e5=SKTexture(imageNamed: "5")
    let e6=SKTexture(imageNamed: "6")
    let e7=SKTexture(imageNamed: "7")
    let e8=SKTexture(imageNamed: "8")
    let e9=SKTexture(imageNamed: "9")
    let e10=SKTexture(imageNamed: "10")
    let e11=SKTexture(imageNamed: "11")
    let e12=SKTexture(imageNamed: "12")
   
    var monstersDestroyed = 0
    var losecount = 0
    var characterU = NSArray()
    var characterD = NSArray()
    var explosion = NSArray()
    var slimeMon = NSArray()
    
    override func didMove(to view: SKView) {
//        let bgm = SKAction.playSoundFileNamed("bgm.wav", waitForCompletion: true)
        if let musicURL = Bundle.main.url(forResource: "bgm", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
//        SKAction.repeatForever(bgm)
        characterD = NSArray(array: [c1,c2,c3,c4])
        characterU = NSArray(array: [c5,c6,c7,c8])
        explosion = NSArray(array: [e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12])
//        backgroundColor = SKColor.white
        background = SKSpriteNode(imageNamed: "ground")
//        background.size = view.bounds.size
        background.size = self.frame.size
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = -1
        addChild(background)
//        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        player.size = CGSize(width: 40, height: 40)
        player.position = CGPoint(x: 0 + player.size.width, y: size.height * 0.5)
           // 4
        addChild(player)
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonster),
            SKAction.wait(forDuration: 1.0)
            ])
        ))
    }

    func addMonster() {
      // Create sprite
         let monster = SKSpriteNode(texture: SKTexture(imageNamed: "slime-1"))
//      let monster = SKSpriteNode(imageNamed: "slime-1")
      monster.size = CGSize(width: 40, height: 40)
      
      monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size) // 1
      monster.physicsBody?.isDynamic = true // 2
      monster.physicsBody?.categoryBitMask = PhysicsCategory.monster // 3
      monster.physicsBody?.contactTestBitMask = PhysicsCategory.projectile // 4
      monster.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
      
      // Determine where to spawn the monster along the Y axis
        let actualX = random(min: size.width * 0.1 + monster.size.width/2, max: size.width * 0.9 - monster.size.width/2)
//         let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
      
      // Position the monster slightly off-screen along the right edge,
      // and along a random position along the Y axis as calculated above
      monster.position = CGPoint(x: actualX , y: size.height + monster.size.width/2)
//         monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
      
      // Add the monster to the scene
        let slime = SKAction.playSoundFileNamed("slimes.wav", waitForCompletion: false)
        run(slime)
      addChild(monster)
      
      // Determine speed of the monster
      let actualDuration = monD
//        random(min: CGFloat(2.0), max: CGFloat(4.0))
      
      // Create the actions
      let actionMove = SKAction.move(to: CGPoint(x: actualX , y: -monster.size.width/2), duration: TimeInterval(actualDuration))
//        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY), duration: TimeInterval(actualDuration))
      let actionMoveDone = SKAction.removeFromParent()
      let loseAction = SKAction.run() { [weak self] in
        guard let `self` = self else { return }
        self.losecount += 1
        let colorize = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.1)
        let returncolor = SKAction.colorize(withColorBlendFactor: 0, duration: 0.1)
        self.background.run(colorize) {
            self.background.run(returncolor)
        }
//        self.background.run(returncolor)
        if (self.losecount == 3){
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false, score: self.hcount * 10)
        self.view?.presentScene(gameOverScene, transition: reveal)
        }
      }
      monster.run(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
    }
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
          return
        }
        run(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
        
        let touchLocation = touch.location(in: self)
        
        // 2 - Set up initial location of projectile
        let projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = player.position
        
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.monster
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.none
        projectile.physicsBody?.usesPreciseCollisionDetection = true
        
        // 3 - Determine offset of location to projectile
        let offset = touchLocation - projectile.position
        
        // 4 - Bail out if you are shooting down or backwards
        if offset.x < 0 { return }
        print("offset:%f,%f",offset.x,offset.y)
        if (offset.x >= 0
            && offset.x <= 50
            ) { player.run(SKAction.move(to: CGPoint(x: player.position.x, y:
//            size.height * 0.9
            touchLocation.y
        ), duration: 1.0))
//            let pScene = SKScene(fileNamed: "Character")
            if (offset.y > 0){player.run(SKAction.animate(with: characterU as! [SKTexture], timePerFrame: 0.25)) }
            else{
                player.run(SKAction.animate(with: characterD as! [SKTexture], timePerFrame: 0.25))}
            
        }
        else{
        
        // 5 - OK to add now - you've double checked position
            addChild(projectile)
            let swing = SKAction.playSoundFileNamed("swing.wav", waitForCompletion: false)
            run(swing)

        // 6 - Get the direction of where to shoot
        let direction = offset.normalized()

        // 7 - Make it shoot far enough to be guaranteed off screen
        let shootAmount = direction * 1000

        // 8 - Add the shoot amount to the current position
        let realDest = shootAmount + projectile.position

        // 9 - Create the actions
            let actionMove = SKAction.move(to: realDest, duration: TimeInterval(proD))
        let actionMoveDone = SKAction.removeFromParent()
            projectile.run(SKAction.sequence([actionMove, actionMoveDone]))}
      }
      
      func projectileDidCollideWithMonster(projectile: SKSpriteNode, monster: SKSpriteNode) {
        print("Hit")
        hcount += 1
        expl.position=projectile.position
        expl.size = CGSize(width: 40, height: 40)
//            projectile.size
        addChild(expl)
//        projectile.run(SKAction.animate(with: explosion as! [SKTexture], timePerFrame: 0.1)),completion: {
//            projectile.removeFromParent()
//        }
        let sound = SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false)
        run(sound)
        expl.run(SKAction.animate(with: explosion as! [SKTexture], timePerFrame: 0.01)) {
            self.expl.removeFromParent()
        }
//        if let explosion = SKEmitterNode(fileNamed: "PlayerExplosion") {
//            explosion.position = player.position
//            addChild(explosion)
//        }

//        let sound = SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false)
//        run(sound)
        projectile.removeFromParent()
        monster.removeFromParent()
//        expl.removeFromParent()
        
        monstersDestroyed += 1
        if monstersDestroyed > 30 {
          let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
          let gameOverScene = GameOverScene(size: self.size, won: true, score: hcount * 10)
          view?.presentScene(gameOverScene, transition: reveal)
        }
      }
    }

    extension GameScene: SKPhysicsContactDelegate {
      func didBegin(_ contact: SKPhysicsContact) {
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
          firstBody = contact.bodyA
          secondBody = contact.bodyB
        } else {
          firstBody = contact.bodyB
          secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.monster != 0) &&
          (secondBody.categoryBitMask & PhysicsCategory.projectile != 0)) {
          if let monster = firstBody.node as? SKSpriteNode,
            let projectile = secondBody.node as? SKSpriteNode {
            projectileDidCollideWithMonster(projectile: projectile, monster: monster)
          }
        }
      }
}
