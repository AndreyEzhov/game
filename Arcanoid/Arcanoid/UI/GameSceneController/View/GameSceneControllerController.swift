//
//  GameSceneControllerController.swift
//  Arcanoid
//
//  Created by Андрей Ежов on 18.11.2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import UIKit
import SpriteKit

/// Контроллер для экрана «GameSceneController»
final class GameSceneControllerController: BaseViewController<GameSceneControllerPresentable>, GameSceneControllerDisplayable {

    // MARK: - Properties
    
    @IBOutlet weak var sceneView: SKView!
    
    /// Есть ли сториборд
    override class var hasStoryboard: Bool { return true }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(fileNamed:"GameScene")
        scene?.scaleMode = .aspectFit
        sceneView.presentScene(scene)
    }
    
    // MARK: - GameSceneControllerDisplayable
    
    // MARK: - Private Functions
    
    // MARK: - Functions

    // MARK: - Actions

}
