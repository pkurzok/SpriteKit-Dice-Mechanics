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

	var diceList = [Dice]()
	var countArea: SKSpriteNode?
	var pointLabel: SKLabelNode?

	override func didMove(to view: SKView) {

		let bg = SKSpriteNode(imageNamed: "bg_blank")
		bg.anchorPoint = CGPoint.zero
		bg.position = CGPoint.zero
		addChild(bg)

		let countArea = SKSpriteNode(imageNamed: "countBg")
		countArea.position = CGPoint(x: 10, y: 300)
		countArea.size = CGSize(width: self.size.width, height: 250)
		addChild(countArea)
		self.countArea = countArea

		let label = SKLabelNode()
		label.text = "0 Points"
		label.fontSize = 65
		label.fontColor = SKColor.white
		label.position = CGPoint(x: 150, y: 350)
		addChild(label)
		self.pointLabel = label

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
		calcPoints()
	}

	// MARK: - PRIVATE
	private func addDice(x: Int, y: Int) {
		let dice = Dice()
		dice.position = CGPoint(x: x, y: y)
		addChild(dice)
		self.diceList.append(dice)
	}

	private func calcPoints() {
		var points = 0
		diceList.forEach {
			if countArea?.intersects($0) ?? false {
				points += $0.value
			}
		}
		pointLabel?.text = "\(points) Points"
	}

}
