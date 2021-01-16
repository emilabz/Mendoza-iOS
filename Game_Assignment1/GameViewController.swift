//
//  GameViewController.swift
//  Game_Assignment1
//
//  Created by Emil Abraham Zachariah on 2020-02-06.
//  Copyright © 2020 Emil Abraham Zachariah. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let scene = GameScene(size: view.bounds.size)
        let scene = MainMenu(fileNamed: "MainMenu")!
        scene.scaleMode = .fill
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        //scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }

//    override var shouldAutorotate: Bool {
//        return true
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
//    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
