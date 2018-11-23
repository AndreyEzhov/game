//
//  UIViewController+Storyboard.swift
//  SocialTrading
//
//  Created by aezhov on 24/01/2018.
//  Copyright © 2018 com.exness. All rights reserved.
//

import UIKit

public func typeCast<T>(_ object: AnyObject?, type: T.Type) -> T? {
    return object as? T
}

public func className(_ class: AnyClass) -> String {
    return NSStringFromClass(`class`).components(separatedBy: ".").last!
}

extension UIViewController {

    // MARK: - Functions

    public class func instantiateFromStoryboard() -> Self {
        let storyboardName = className(self)
        let controller = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
        return typeCast(controller, type: self)!
    }

    public func embedChildViewController(_ childController: UIViewController, toView childContainerView: UIView) {
        guard let view = childController.view else {
            return
        }

        addChild(childController)

        view.translatesAutoresizingMaskIntoConstraints = false
        childController.beginAppearanceTransition(true, animated: true)
        childContainerView.addSubview(view)
        let views = [ "v": view ]
        let rules = [ "V:|[v]|", "H:|[v]|" ]
        for rule in rules {
            childContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: rule, options: [], metrics: nil, views: views))
        }

        childController.didMove(toParent: self)
        childController.endAppearanceTransition()
    }

    public func unembedChildViewController(_ controller: UIViewController?) {
        guard let controller = controller else {
            return
        }
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
}
