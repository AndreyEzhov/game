//
//  GameLevelNode.swift
//  Arcanoid
//
//  Created by Андрей Ежов on 22.11.2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import UIKit
import SpriteKit

class GameLevelNode: SKSpriteNode {

    init(width: CGFloat) {
        let size = CGSize(width: width, height: 2.0)
        super.init(texture: nil,
                   color: UIColor.clear,
                   size: size)
        let physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody = physicsBody
        physicsBody.categoryBitMask = GameAreaCategory
        physicsBody.collisionBitMask = BallCategory
        physicsBody.isDynamic = false
        physicsBody.usesPreciseCollisionDetection = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
