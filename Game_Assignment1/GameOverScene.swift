//
//  GameOverScene.swift
//  Game_Assignment1
//
//  Created by Emil Abraham Zachariah on 2020-02-06.
//  Copyright © 2020 Emil Abraham Zachariah. All rights reserved.
//

import Foundation
import SpriteKit
var highScoreText: UITextField!
class GameOverScene: SKScene, UITextFieldDelegate {
    var defaults = UserDefaults.standard
    var names = [String]()
    var scores = [Int]()
    var playerName=""
    var playerscore=0
//    buttonPlay = self.childNode(withName: "PlayButton") as! MSButtonNode
    init(size: CGSize, won:Bool, score:Int) {
    super.init(size: size)
        playerscore=score
    
    // 1
//    backgroundColor = SKColor(hue: 35/360, saturation: 80/100, brightness: 100/100, alpha: 1.0)
        let background = SKSpriteNode(imageNamed: "menu-bg")
        background.size = self.frame.size
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = -1
         let colorize = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.1)
        addChild(background)
        background.run(colorize)
    
    // 2
    let message = "GAME OVER"
    let scoremsg = "Score is \(score)"
//        won ? "You Won!" : "You Lose :["
    
    // 3
    let label = SKLabelNode(fontNamed: "MarkerFelt-Wide")
    let scorelbl = SKLabelNode(fontNamed: "MarkerFelt-Wide")
    label.text = message
    label.fontSize = 40
    label.fontColor = SKColor(hue: 35/360, saturation: 80/100, brightness: 100/100, alpha: 1.0)
    label.position = CGPoint(x: size.width/2, y: size.height/2+150)
    addChild(label)
        scorelbl.text = scoremsg
        scorelbl.fontSize = 40
        scorelbl.fontColor = SKColor(hue: 35/360, saturation: 80/100, brightness: 100/100, alpha: 1.0)
        scorelbl.position = CGPoint(x: size.width/2, y: size.height/2+50)
        addChild(scorelbl)
    
    
    
    // 4
    /*run(SKAction.sequence([
      SKAction.wait(forDuration: 3.0),
      SKAction.run() { [weak self] in
        // 5
        guard let `self` = self else { return }
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
//        let scene = GameScene(size: size)
         let scene = MainMenu(fileNamed: "MainMenu")!
        scene.scaleMode = .fill
        self.view?.presentScene(scene, transition:reveal)
      }
      ]))*/
  }
  
  // 6
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    override func didMove(to view: SKView) {
       names = defaults.stringArray(forKey: "Name") ?? [String]()
        scores = defaults.array(forKey: "Score")  as? [Int] ?? [Int]()
//        let submit = SKSpriteNode(imageNamed: "submit_btn")
//        submit.position = CGPoint(x: size.width/2, y: size.height/2-100)
//        submit.size = CGSize(width: 100, height: 50)
//        submit.name = "submit"
//        addChild(submit)
        
        
        ////
        highScoreText = UITextField(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height / 2 - 20, width: 320, height: 40))
//        highScoreText.becomeFirstResponder()
              // add the UITextField to the GameScene's view
//        view.addSubview(highScoreText)
             
              // add the gamescene as the UITextField delegate.
              // delegate funtion called is textFieldShouldReturn:
              highScoreText.delegate = self
        
            
        highScoreText.borderStyle = UITextField.BorderStyle.roundedRect
        highScoreText.textColor = SKColor.black
              highScoreText.placeholder = "Enter your name here"
        highScoreText.backgroundColor = SKColor.white
        highScoreText.autocorrectionType = UITextAutocorrectionType.yes
               
        highScoreText.clearButtonMode = UITextField.ViewMode.whileEditing
        highScoreText.autocapitalizationType = UITextAutocapitalizationType.allCharacters
              self.view!.addSubview(highScoreText)
        
        ////
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          // Populates the SKLabelNode
//          submitScoreText.text = textField.text
        if (textField.text==""){
            playerName = "Player"
        }
        else{
            playerName = textField.text!
            print("name - \(playerName)")
        }
        print("text",textField.text ?? "none")
    
          // Hides the keyboard
    
          textField.resignFirstResponder()
        next()
          return true
      }
    func next(){
        if (names.isEmpty && scores.isEmpty){
                    names.append(playerName)
                    scores.append(playerscore)
                    defaults.set(names, forKey: "Name")
                    defaults.set(scores, forKey: "Score")
                }
                else{
                    names.append(playerName)
                    scores.append(playerscore)
                    defaults.set(names, forKey: "Name")
                    defaults.set(scores, forKey: "Score")
                }
                print(names.count)
                run(SKAction.sequence([
                      SKAction.wait(forDuration: 1.0),
                      SKAction.run() { [weak self] in
                        // 5
                        guard let `self` = self else { return }
                        highScoreText.removeFromSuperview()
                        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                //        let scene = GameScene(size: size)
                         let scene = MainMenu(fileNamed: "MainMenu")!
                        scene.scaleMode = .fill
                        self.view?.presentScene(scene, transition:reveal)
                      }
                      ]))
    }
   /* override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
             let location = touch.location(in: self)
             let touchedNode = atPoint(location)
             if touchedNode.name == "submit" {
                  print("Submit clicked")
                if (names.isEmpty && scores.isEmpty){
                    names.append(playerName)
                    scores.append(playerscore)
                    defaults.set(names, forKey: "Name")
                    defaults.set(scores, forKey: "Score")
                }
                else{
                    names.append(playerName)
                    scores.append(playerscore)
                    defaults.set(names, forKey: "Name")
                    defaults.set(scores, forKey: "Score")
                }
                print(names.count)
                run(SKAction.sequence([
                      SKAction.wait(forDuration: 1.0),
                      SKAction.run() { [weak self] in
                        // 5
                        guard let `self` = self else { return }
                        highScoreText.removeFromSuperview()
                        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                //        let scene = GameScene(size: size)
                         let scene = MainMenu(fileNamed: "MainMenu")!
                        scene.scaleMode = .fill
                        self.view?.presentScene(scene, transition:reveal)
                      }
                      ]))
             }
            else if(touchedNode.name == "submit")
        }
    }*/
}

