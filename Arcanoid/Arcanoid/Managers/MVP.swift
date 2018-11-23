//
//  MVP.swift
//  Arcanoid
//
//  Created by Андрей Ежов on 18.11.2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import UIKit

protocol View: class {}

protocol Presenter: AnyPresenter {
    
    associatedtype T
    
    func contentView () -> T?
    
}

extension Presenter {
    
    func contentView () -> T? {
        return self.view as? T
    }
    
}

protocol AnyPresenter: class {
    var view: View? { get set }
    
    /// Обработка отображения вью
    func onBecomeVisible()
}

extension AnyPresenter {
    
    func onBecomeVisible() {}
    
    func onWillDisappear() {}
    
    var analyticsTitle: String { return "" }
    
    var analyticsParams: [String: Any] { return [:] }
    
}

class BaseViewController<T>: UIViewController, View {
    
    // MARK: - Properties
    
    var titleString: String? { return nil }
    
    var navigationBarIsHidden: Bool { return false }
    
    private(set) var presenter: T!
    
    /// Есть ли сториборд
    class var hasStoryboard: Bool { return true }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (presenter as? AnyPresenter)?.onBecomeVisible()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        (presenter as? AnyPresenter)?.onWillDisappear()
    }
    
    class func controller(presenter: T) -> UIViewController {
        let vc = hasStoryboard ? instantiateFromStoryboard() : createController(aClass: self)
        
        if let vc = vc as? BaseViewController {
            vc.presenter = presenter
            (presenter as? AnyPresenter)?.view = vc
        }
        return vc
    }
    
    private static func createController(aClass: UIViewController.Type) -> UIViewController {
        return aClass.init(nibName: nil, bundle: nil)
    }
}
