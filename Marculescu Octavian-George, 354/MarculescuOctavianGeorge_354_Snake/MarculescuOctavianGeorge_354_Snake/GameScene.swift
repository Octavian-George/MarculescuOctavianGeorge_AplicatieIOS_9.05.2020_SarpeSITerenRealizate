//
//  GameScene.swift
//  MarculescuOctavianGeorge_354_Snake
//
//  Created by user169232 on 5/5/20.
//  Copyright © 2020 Marculescu Octavian. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var gameLogo: SKLabelNode!
    var gameProgrammer: SKLabelNode!
    var bestScore: SKLabelNode!
    var playButton: SKShapeNode!
    var game: GameManager!
    
    var currentScore: SKLabelNode!
    var playerPositions: [(Int, Int)] = []
    var gameBG: SKShapeNode!
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
   
    
    override func didMove(to view: SKView) {
        meniulJocului()
        game=GameManager(scene:self)
        spatiulDeJoaca()
}
    
    override func update(_ currentTime: TimeInterval) {
         //Called before each frame is rendered
    }
    private func meniulJocului() {
        //Titlul proiectului
        gameLogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 200)
        gameLogo.fontSize = 50
        gameLogo.text = "Proiect Snake"
        gameLogo.fontColor = SKColor.red
        self.addChild(gameLogo)
        //Numele creatorului
        gameProgrammer = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gameProgrammer.zPosition = 1
        gameProgrammer.position = CGPoint(x: 0, y: gameLogo.position.y + 59)
        gameProgrammer.fontSize = 35
        gameProgrammer.text = "Marculescu Octavian-George,Grupa 354"
        gameProgrammer.fontColor = SKColor.green
        self.addChild(gameProgrammer)
        //Cel mai bun scor
        bestScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: gameLogo.position.y - 50)
        bestScore.fontSize = 40
        bestScore.text = "Cel mai mare punctaj obtinut: 0"
        bestScore.fontColor = SKColor.white
        self.addChild(bestScore)
        //Butonul de start
        playButton = SKShapeNode()
        playButton.name = "play_button"
        playButton.zPosition = 1
        playButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 200)
        playButton.fillColor = SKColor.red
        let topCorner = CGPoint(x: -50, y: 50)
        let bottomCorner = CGPoint(x: -50, y: -50)
        let middle = CGPoint(x: 50, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        playButton.path = path
        self.addChild(playButton)
  }
    
    //functia de interactionare cu butonul de start
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "play_button" {
                    startGame()
                }
            }
        }
    }
    
    private func spatiulDeJoaca() {
        //4
        currentScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x: 0, y: (frame.size.height / -2) + 60)
        currentScore.fontSize = 40
        currentScore.isHidden = true
        currentScore.text = "Puncte obtinute:0"
        currentScore.fontColor = SKColor.white
        self.addChild(currentScore)
        //5
        let width = frame.size.width
        let height = frame.size.height-200
        let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
        gameBG = SKShapeNode(rect: rect, cornerRadius: 0.02)
        gameBG.fillColor = SKColor.darkGray
        gameBG.zPosition = 2
        gameBG.isHidden = true
        self.addChild(gameBG)
        //6
        createGameBoard(width: Int(width), height: Int(height))
    }
    
    private func createGameBoard(width: Int, height: Int) {
        //formarea spatiului de joaca
        let cellWidth: CGFloat = 27.5
        let numRows = 41
        let numCols = 27
        var x = CGFloat(width / -2) + (cellWidth / 2)
        var y = CGFloat(height / 2) - (cellWidth / 2)
        for i in 0...numRows - 1 {
            for j in 0...numCols - 1 {
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                cellNode.strokeColor = SKColor.black
                cellNode.zPosition = 2
                cellNode.position = CGPoint(x: x, y: y)
                gameArray.append((node: cellNode, x: i, y: j))
                gameBG.addChild(cellNode)
                x += cellWidth
            }
            //reset x, iterate y
            x = CGFloat(width / -2) + (cellWidth / 2)
            y -= cellWidth
        }
    }

    private func startGame(){
        print ("Jocul a inceput")
        gameLogo.run(SKAction.move(by: CGVector(dx: -50, dy: 600), duration: 0.5)) {
        self.gameLogo.isHidden = true
        }
        gameProgrammer.run(SKAction.move(by: CGVector(dx: -50, dy: 600), duration: 0.5)) {
        self.gameProgrammer.isHidden = true
        }
        playButton.run(SKAction.scale(to: 0, duration: 0.3)) {
            self.playButton.isHidden = true
        }
        let bottomCorner = CGPoint(x: 0, y: (frame.size.height / -2) + 20)
        bestScore.run(SKAction.move(to: bottomCorner, duration: 0.4))
            self.gameBG.setScale(0)
            self.currentScore.setScale(0)
            self.gameBG.isHidden = false
            self.currentScore.isHidden = false
            self.gameBG.run(SKAction.scale(to: 1, duration: 0.4))
            self.currentScore.run(SKAction.scale(to: 1, duration: 0.4))
            self.game.initGame()
        }
}

