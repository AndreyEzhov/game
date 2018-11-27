//
//  WaitingViewControllerPresenter.swift
//  Arcanoid
//
//  Created by aezhov on 27/11/2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import Foundation

/// Протокол для общения с вью частью
protocol WaitingViewControllerDisplayable: View {

}

/// Интерфейс презентера
protocol WaitingViewControllerPresentable: Presenter {

}

/// Презентер для экрана «WaitingViewController»
final class WaitingViewControllerPresenter: WaitingViewControllerPresentable {
    
    // MARK: - Nested types
    
    typealias T = WaitingViewControllerDisplayable
    
    // MARK: - Properties
    
    weak var view: View?
    
    private let storage: RCValues
    
    // MARK: - Construction
    
    init(storage: RCValues) {
        self.storage = storage
        
        if storage.fetchComplete {
            startAppForReal()
        }
        
        storage.loadingDoneCallback = startAppForReal
    }
    
    // MARK: - Private Functions
    
    private func startAppForReal() {
        
    }
    
    // MARK: - Functions
    
    // MARK: - WaitingViewControllerPresentable

}
