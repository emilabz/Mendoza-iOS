//
//  MainMenu.swift
//  
//
//  Created by Emil Abraham Zachariah on 2020-02-11.
//

import Foundation
import SpriteKit

class MainMenu: SKScene {

/* UI Connections */
    var buttonPlay: MSButtonNode!
    var btnScore:MSButtonNode!
    var btn_easy:MSButtonNode!
    var btn_medium:MSButtonNode!
    var btn_hard:MSButtonNode!
    var sel = 1

    override func didMove(to view: SKView) {
        /* Setup your scene here */

        /* Set UI connections */
        buttonPlay = self.childNode(withName: "PlayButton") as! MSButtonNode
        btnScore = self.childNode(withName: "ScoreboardButton") as! MSButtonNode
        btn_easy = self.childNode(withName: "EasyButton") as! MSButtonNode
        btn_medium = self.childNode(withName: "MediumButton") as! MSButtonNode
        btn_hard = self.childNode(withName: "HardButton") as! MSButtonNode
        buttonPlay.selectedHandler = {
            self.loadGame()
        }
        btn_easy.selectedHandler = {
            self.sel=1
        }
        btn_medium.selectedHandler = {
            self.sel=2
        }
        btn_hard.selectedHandler = {
            self.sel=3
        }
        btnScore.selectedHandler = {
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let scoreScene=ScoreBoardScene(size: self.size)
            self.view?.presentScene(scoreScene, transition: reveal)
        }

    }
    
    func loadGame() {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view else {
            print("Could not get Skview")
            return
        }

        /* 2) Load Game scene */
        
//        let scene = GameScene(speed: sel)
        let scene = GameScene(size: (view?.bounds.size)!,speed: sel)
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .resizeFill
//            .aspectFill

        /* Show debug */
        skView.showsPhysics = true
        skView.showsDrawCount = true
        skView.showsFPS = true

        /* 4) Start game scene */
        skView.presentScene(scene)
    }
    
}
