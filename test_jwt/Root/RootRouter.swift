//
//  RootRouter.swift
//  Pehchan
//
//  Created by farees.syed on 06/03/25.
//

import Foundation
import UIKit

protocol RootRouterProtocol {
    func showFieldScreen()
    func dismissPresentedViewControllers()
}

final class RootRouter: RootRouterProtocol {
    weak var viewController: RootViewController?
    
    func showFieldScreen() {
        
    }
    
    func removeAllChildController() {
        viewController?.children.forEach {
            UIHelper.removeChildViewController(childVC: $0)
        }
    }
    
    func dismissPresentedViewControllers() {
        removeAllChildController()
    }
}
