//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

/// Протокол для общения с вью частью
protocol ___VARIABLE_Name___Displayable: View {

}

/// Интерфейс презентера
protocol ___VARIABLE_Name___Presentable: Presenter {

}

/// Презентер для экрана «___VARIABLE_LocalizedName___»
final class ___VARIABLE_Name___Presenter: ___VARIABLE_Name___Presentable {
    
    // MARK: - Nested types
    
    typealias T = ___VARIABLE_Name___Displayable
    
    // MARK: - Properties
    
    weak var view: View?
    
    // MARK: - Construction
    
    init() {
        
    }
    
    // MARK: - Private Functions
    
    // MARK: - Functions
    
    // MARK: - ___VARIABLE_Name___Presentable

}
