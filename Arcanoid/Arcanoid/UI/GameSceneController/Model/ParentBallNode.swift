//
//  ParentBallNode.swift
//  Arcanoid
//
//  Created by Андрей Ежов on 21.11.2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import UIKit
import SpriteKit

class ParentBallNode: SKSpriteNode {

    init() {
        let texture = SKTexture(imageNamed: "ball")
        super.init(texture: texture,
                   color: UIColor.clear,
                   size: CGSize(width: ballSize, height: ballSize))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
