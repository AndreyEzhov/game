//
//  WaitingViewControllerController.swift
//  Arcanoid
//
//  Created by aezhov on 27/11/2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import UIKit

/// Контроллер для экрана «WaitingViewController»
final class WaitingViewControllerController: BaseViewController<WaitingViewControllerPresentable>, WaitingViewControllerDisplayable {

    // MARK: - Properties

    /// Есть ли сториборд
    override class var hasStoryboard: Bool { return true }

    // MARK: - Life Cycle

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - WaitingViewControllerDisplayable
    
    // MARK: - Private Functions
    
    // MARK: - Functions

    // MARK: - Actions

}
