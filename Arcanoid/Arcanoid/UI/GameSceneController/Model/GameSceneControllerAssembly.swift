//
//  GameSceneControllerAssembly.swift
//  Arcanoid
//
//  Created by Андрей Ежов on 18.11.2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import UIKit

/// Сборщик экрана «GameSceneController»
protocol GameSceneControllerAssembly {
    
    /// Экран «GameSceneController»
    ///
    /// - Returns: View Controller
    func createGameSceneControllerController() -> UIViewController
    
}

extension Assembly: GameSceneControllerAssembly {
    
    /// Экран «GameSceneController»
    ///
    /// - Returns: View Controller
    func createGameSceneControllerController() -> UIViewController {
        let presenter = GameSceneControllerPresenter()
        return GameSceneControllerController.controller(presenter: presenter)
    }
    
}
