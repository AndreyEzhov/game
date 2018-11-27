//
//  GameSceneControllerPresenter.swift
//  Arcanoid
//
//  Created by Андрей Ежов on 18.11.2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import Foundation

/// Протокол для общения с вью частью
protocol GameSceneControllerDisplayable: View {

}

/// Интерфейс презентера
protocol GameSceneControllerPresentable: Presenter {
    var gameScenePresenter: GameScenePresenterProtocol { get }
}

/// Презентер для экрана «GameSceneController»
final class GameSceneControllerPresenter: GameSceneControllerPresentable {
    
    // MARK: - Nested types
    
    typealias T = GameSceneControllerDisplayable
    
    // MARK: - Properties
    
    weak var view: View?
    
    let gameScenePresenter: GameScenePresenterProtocol = GameScenePresenter()
    
    // MARK: - Construction
    
    init() {
        
    }
    
    // MARK: - Private Functions
    
    // MARK: - Functions
    
    // MARK: - GameSceneControllerPresentable

}
