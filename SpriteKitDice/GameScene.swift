//
//  GameScene.swift
//  SpriteKitDice
//
//  Created by Peter Kurzok on 09.10.20.
//

import GameplayKit
import SpriteKit

enum DiceLevel: CGFloat {
	case board = 10
	case moving = 100
	case enlarged = 200
}

class GameScene: SKScene {

	override func didMove(to view: SKView) {

		let bg = SKSpriteNode(imageNamed: "bg_blank")
		bg.anchorPoint = CGPoint.zero
		bg.position = CGPoint.zero
		addChild(bg)

		addDice(x: 100, y: 100)
		addDice(x: 50, y: 50)
	}
	// MARK: - TOUCHES
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let location = touch.location(in: self)
			if let dice = atPoint(location) as? Dice {
				dice.position = location
			}
		}
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let location = touch.location(in: self)
			if let dice = atPoint(location) as? Dice {
				dice.zPosition = DiceLevel.moving.rawValue
				dice.removeAction(forKey: "drop")
				dice.run(SKAction.scale(to: 1.3, duration: 0.15), withKey: "pickup")
			}
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let location = touch.location(in: self)
			if let dice = atPoint(location) as? Dice {
                
                if touch.tapCount > 1 {
                    dice.roll()
                }
                
				dice.zPosition = DiceLevel.board.rawValue
				dice.removeFromParent()
				addChild(dice)
				dice.removeAction(forKey: "pickup")
				dice.run(SKAction.scale(to: 1.0, duration: 0.15), withKey: "drop")
			}
		}
	}

	// MARK: - PRIVATE
	fileprivate func addDice(x: Int, y: Int) {
		let dice = Dice()
		dice.position = CGPoint(x: x, y: y)
		addChild(dice)
	}

}
