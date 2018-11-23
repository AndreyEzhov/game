//
//  BrickNode.swift
//  Arcanoid
//
//  Created by Андрей Ежов on 18.11.2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import UIKit
import SpriteKit

class BrickNode: SKSpriteNode {
    
    private var hitPoints: Int
    
    private let label = SKLabelNode()
    
    init(hitPoints: Int) {
        self.hitPoints = hitPoints
        let size = CGSize(width: 40.0, height: 40.0)
        super.init(texture: nil,
                   color: BrickNode.color(for: hitPoints),
                   size: size)
        let physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody = physicsBody
        physicsBody.defaultSetup()
        physicsBody.categoryBitMask = BlockCategory
        physicsBody.contactTestBitMask = BallCategory
        physicsBody.collisionBitMask = BallCategory
        physicsBody.isDynamic = false
        physicsBody.allowsRotation = false
        physicsBody.usesPreciseCollisionDetection = true
        addChild(label)
        label.fontColor = UIColor.black
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.fontName = UIFont.applicationFontName
        label.fontSize = 25
        updateState()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func damage(with value: Int) {
        hitPoints -= value
        if hitPoints == 0 {
            destroy()
        }
        updateState()
    }
    
    private func updateState() {
        label.text = "\(hitPoints)"
        self.color = BrickNode.color(for: hitPoints)
    }
    
    private static func color(for hitPoints: Int) -> UIColor {
        return UIColor(red: CGFloat(1.0 - Double(hitPoints * 10)/255.0), green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    private func destroy() {
        removeFromParent()
    }

}
