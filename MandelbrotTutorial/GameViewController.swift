//
//  GameViewController.swift
//  MandelbrotTutorial
//
//  Created by Silviu Pop on 5/15/15.
//  Copyright (c) 2015 WeHeartSwift. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .mappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData as Data)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    var node:SKSpriteNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene.unarchiveFromFile(file: "GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .fill
            
            node = scene.childNode(withName: "fractal") as? SKSpriteNode
            
            skView.presentScene(scene)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
