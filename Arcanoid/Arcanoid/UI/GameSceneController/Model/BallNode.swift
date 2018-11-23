//
//  BallNode.swift
//  Arcanoid
//
//  Created by Андрей Ежов on 18.11.2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import UIKit
import SpriteKit

let ballSize: CGFloat = 16.0

class BallNode: SKSpriteNode {
    
    var ballInGame = false
    
    init() {
        let texture = SKTexture(imageNamed: "ball")
        super.init(texture: texture,
                   color: UIColor.clear,
                   size: CGSize(width: ballSize, height: ballSize))
        let physicsBody = SKPhysicsBody(circleOfRadius: ballSize / 2.0)
        self.physicsBody = physicsBody
        physicsBody.defaultSetup()
        physicsBody.categoryBitMask = BallCategory
        physicsBody.contactTestBitMask = FloorCategory | BlockCategory | GameAreaCategory
        physicsBody.collisionBitMask = BorderCategory | BlockCategory
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = false
        physicsBody.usesPreciseCollisionDetection = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyImpulse(_ impulse: CGVector) {
        physicsBody?.applyImpulse(impulse)
    }
    
}
