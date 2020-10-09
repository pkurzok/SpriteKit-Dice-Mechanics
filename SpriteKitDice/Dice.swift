//
//  Dice.swift
//  SpriteKitDice
//
//  Created by Peter Kurzok on 09.10.20.
//

import GameplayKit
import SpriteKit

class Dice: SKSpriteNode {

	let d6 = GKRandomDistribution.d6()
	let length = 50

	var value: Int
	

	required init?(coder aDecoder: NSCoder) {
		fatalError("NSCoding not supported")
	}

	init() {
		self.value = d6.nextInt()

		super.init(texture: SKTexture(imageNamed: "\(value)"), color: .clear, size: CGSize(width: length, height: length))
	}
    
    func roll() {
        self.value = d6.nextInt()
        self.texture = SKTexture(imageNamed: "\(value)")
    }
}
