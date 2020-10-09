//
//  GameViewController.swift
//  SpriteKitDice
//
//  Created by Peter Kurzok on 09.10.20.
//

import GameplayKit
import SpriteKit
import UIKit

class GameViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let skView = self.view as! SKView

        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill

        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = false
		skView.presentScene(scene)
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}
}
