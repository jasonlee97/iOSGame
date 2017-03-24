//
//  GameOverScene.swift
//  iOSGame
//
//  Created by Kevin Tieu on 2017-02-17.
//  Copyright © 2017 Kevin Tieu. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    let button = SKSpriteNode(imageNamed: "restartbutton")
    let gameover = SKSpriteNode(imageNamed: "gameover")
    let background = SKSpriteNode(imageNamed: "grass-background.jpg") // background image on the gameover scene
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = 1
        addChild(background)

        gameover.position = CGPoint(x: size.width/2, y: size.height/1.3)
        gameover.zPosition = 2
        addChild(gameover)
        
        button.position = CGPoint(x: size.width/2, y: size.height/2)
        button.zPosition = 2
        addChild(button)
        
        let label1 = SKLabelNode(fontNamed: "Chalkduster")
        label1.text = "label1"
        label1.fontSize = 28
        label1.fontColor = .black
        label1.position = CGPoint(x: size.width / 2, y: 150)
        label1.zPosition = 3
        addChild(label1)
        
        let label2 = SKLabelNode(fontNamed: "Chalkduster")
        label2.text = "label2"
        label2.fontSize = 28
        label2.fontColor = .black
        label2.position = CGPoint(x: size.width / 2, y: 100)
        label2.zPosition = 3
        addChild(label2)
        
        let label3 = SKLabelNode(fontNamed: "Chalkduster")
        label3.text = "label3"
        label3.fontSize = 28
        label3.fontColor = .black
        label3.position = CGPoint(x: size.width / 2, y: 50)
        label3.zPosition = 3
        addChild(label3)
        
        
        if !UserDefaults.standard.bool(forKey: "HasLaunchedOnce") {
            print("INSIDE HAS LAUNCHED ONCE")
            
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
            
            var scoreArray = [0, 0, 0]
            
            let score = Int(UserDefaults.standard.string(forKey: "myKey")!)!

            if score > scoreArray[2] {
                for i in 0 ..< scoreArray.count {
                    if score > scoreArray[i] && score != scoreArray[0] &&
                        score != scoreArray[1] && score != scoreArray[2] {
                        for j in (i+1 ..< scoreArray.count).reversed() {
                            scoreArray[j] = scoreArray[j-1]
                        }
                        scoreArray[i] = score
                        break
                    }
                }
            }
            
            //save new array
            let defaults = UserDefaults.standard
            defaults.set(scoreArray, forKey: "SavedIntArray")
            
            //display all value
            label1.text = "\(scoreArray[0])"
            label2.text = "\(scoreArray[1])"
            label3.text = "\(scoreArray[2])"
        } else {
            let score = Int(UserDefaults.standard.string(forKey: "myKey")!)!
            print(score)
            
            let defaults = UserDefaults.standard
            
            //retrieve existed array and display
            var scoreArray = defaults.array(forKey: "SavedIntArray") as? [Int] ?? [Int]()
            
            //sort array with new score
            if score > scoreArray[2] {
                for i in 0 ..< scoreArray.count {
                    if score > scoreArray[i] {
                        for j in (i+1 ..< scoreArray.count).reversed() {
                            scoreArray[j] = scoreArray[j-1]
                        }
                        scoreArray[i] = score
                        break
                    }
                }
            }
            
            //save new array
            defaults.set(scoreArray, forKey: "SavedIntArray")
            
            //display all value
            label1.text = "\(scoreArray[0])"
            label2.text = "\(scoreArray[1])"
            label3.text = "\(scoreArray[2])"
        }
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "myKey")
        
        let message = "Your Score: " + token!
        
        let label = SKLabelNode(fontNamed: "Thonburi-Bold")
        label.text = message
        label.fontSize = 30
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width/2, y: size.height/3)
        label.zPosition = 2
        addChild(label)
        
        
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let location = touch.location(in: self)
            
            // detect touch on button
            if(self.button.contains(location)) {
                let gameScene = GameScene(size: self.size)
                let skView = self.view
                
                gameScene.scaleMode = SKSceneScaleMode.aspectFill
                gameScene.reset()
                skView?.presentScene(gameScene)
            }
        }
    }
}
