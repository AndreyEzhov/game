//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

/// Сборщик экрана «___VARIABLE_LocalizedName___»
protocol ___VARIABLE_Name___Assembly {
    
    /// Экран «___VARIABLE_LocalizedName___»
    ///
    /// - Returns: View Controller
    func create___VARIABLE_Name___Controller() -> UIViewController
    
}

extension Assembly: ___VARIABLE_Name___Assembly {
    
    /// Экран «___VARIABLE_LocalizedName___»
    ///
    /// - Returns: View Controller
    func create___VARIABLE_Name___Controller() -> UIViewController {
        let presenter = ___VARIABLE_Name___Presenter()
        return ___VARIABLE_Name___Controller.controller(presenter: presenter)
    }
    
}
