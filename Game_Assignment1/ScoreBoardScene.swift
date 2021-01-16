//
//  ScoreBoardScene.swift
//  Game_Assignment1
//
//  Created by Emil Abraham Zachariah on 2020-02-12.
//  Copyright © 2020 Emil Abraham Zachariah. All rights reserved.
//

import Foundation
import SpriteKit
//import UIKit
class ScoreBoardScene: SKScene {
    var gameTableView = GameRoomTableView()
    let defaults = UserDefaults.standard
    var names = [String]()
    var scores = [Int]()
    private var label : SKLabelNode?
    override func didMove(to view: SKView) {
        names = defaults.stringArray(forKey: "Name") ?? [String]()
        scores = defaults.array(forKey: "Score")  as? [Int] ?? [Int]()
//        backgroundColor=SKColor(hue: 35/360, saturation: 80/100, brightness: 100/100, alpha: 1.0)
        let background = SKSpriteNode(imageNamed: "menu-bg")
        background.size = self.frame.size
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        let label = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        label.text = "SCOREBOARD"
        label.fontSize = 80
//        label.fontColor = SKColor(hue: 35/360, saturation: 80/100, brightness: 100/100, alpha: 1.0)
        label.position = CGPoint(x: frame.size.width / 2, y: 900)
        addChild(label)
        
        print("namesize \(names.count)")
        for n in names{
            print("name \(n)")
        }
        
       let backbtn = SKSpriteNode(imageNamed: "back_btn.png")
        backbtn.size = CGSize(width: 150, height: 100)
        backbtn.position = CGPoint(x: frame.size.width/2, y: 100)
        backbtn.name="back"
        addChild(backbtn)

//        scores = defaults.array(forKey: "Score")  as? [Int] ?? [Int]()
//        self.label = self.childNode(withName: "//ScoreInfo") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
        // Table setup
        if (names.isEmpty || scores.isEmpty){
            label.text="NO SCORES ENTERED"
        }
        else{
            gameTableView.setData(tnames: names, tscores: scores)
            gameTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        gameTableView.frame=CGRect(x:view.frame.width/2-90,y:view.frame.height/2-100,width:180,height:200)
            self.scene?.view?.addSubview(gameTableView)
            gameTableView.reloadData()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "back" {
                gameTableView.removeFromSuperview()
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let scene = MainMenu(fileNamed: "MainMenu")!
                scene.scaleMode = .fill
                self.view?.presentScene(scene, transition:reveal)
            }
        }
    }
}
