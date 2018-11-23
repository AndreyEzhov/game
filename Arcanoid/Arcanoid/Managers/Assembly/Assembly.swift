//
//  Assembly.swift
//  Arcanoid
//
//  Created by Андрей Ежов on 18.11.2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import UIKit

class Assembly {
    
    // MARK: - Properties
    
    static var shared = Assembly()
    
    // MARK: - Construction
    
    private init () {}
    
    // MARK: - Functions
    
    func root() -> UIViewController {
        return UINavigationController(rootViewController: createGameSceneControllerController())
    }

}
