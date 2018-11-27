//
//  WaitingViewControllerAssembly.swift
//  Arcanoid
//
//  Created by aezhov on 27/11/2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import UIKit

/// Сборщик экрана «WaitingViewController»
protocol WaitingViewControllerAssembly {
    
    /// Экран «WaitingViewController»
    ///
    /// - Returns: View Controller
    func createWaitingViewControllerController() -> UIViewController
    
}

extension Assembly: WaitingViewControllerAssembly {
    
    /// Экран «WaitingViewController»
    ///
    /// - Returns: View Controller
    func createWaitingViewControllerController() -> UIViewController {
        let presenter = WaitingViewControllerPresenter(storage: remoteConfigStorage)
        return WaitingViewControllerController.controller(presenter: presenter)
    }
    
}
