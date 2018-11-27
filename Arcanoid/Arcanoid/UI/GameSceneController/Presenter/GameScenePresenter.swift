//
//  GameScenePresenter.swift
//  Arcanoid
//
//  Created by aezhov on 27/11/2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

protocol GameScenePresenterProtocol: class {
    var gameScene: GameScene? { get set }
}

class GameScenePresenter: GameScenePresenterProtocol {
    
    // MARK: - Properties
    
    weak var gameScene: GameScene?
    
    // MARK: - Construction
    
    // MARK: - Private Functions
}

