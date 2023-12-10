//
//  Extension.swift
//  SmallWorldTest_UIKit
//
//  Created by Sabih Haris on 10/12/2023.
//

import Foundation
import UIKit

class ViewPresenter {
    
    public static func replaceRootView(for viewController: UIViewController,
                                       duration: TimeInterval = 1.5,
                                       options: UIView.AnimationOptions = .transitionCrossDissolve,
                                       completion: ((Bool) -> Void)? = nil) {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        viewController.view.frame = UIScreen.main.bounds
        window.rootViewController = viewController
    }
}

extension UIViewController {
    
    class func initWithNib<T : UIViewController>() -> T {
        return self.init(nibName: String(describing: self.classForCoder()), bundle: nil) as! T
    }
    
}
