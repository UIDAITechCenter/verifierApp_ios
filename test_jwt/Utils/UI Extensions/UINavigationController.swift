//
//  UINavigationController.swift
//  Pehchan
//
//  Created by farees.syed on 12/03/25.
//

import UIKit

public extension UINavigationController {
    private struct AssociatedKeys {
        static var interactiveDelegate: UInt8 = 0
    }

    private var interactiveDelegate: InteractiveNavigationPopRecognizer? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.interactiveDelegate) as? InteractiveNavigationPopRecognizer }
        set { objc_setAssociatedObject(self, &AssociatedKeys.interactiveDelegate, newValue, .OBJC_ASSOCIATION_COPY) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        resetPopGesture()
    }

    func resetPopGesture() {
        interactiveDelegate = InteractiveNavigationPopRecognizer(controller: self)
        self.interactivePopGestureRecognizer?.delegate = interactiveDelegate
        self.interactivePopGestureRecognizer?.isEnabled = true
    }
}

public extension UINavigationController
{
    /// Given the kind of a (UIViewController subclass),
    /// removes any matching instances from self's
    /// viewControllers array.

    func removeAnyViewControllers(ofKind kind: AnyClass)
    {
        self.viewControllers = self.viewControllers.filter { !$0.isKind(of: kind)}
    }

    /// Given the kind of a (UIViewController subclass),
    /// returns true if self's viewControllers array contains at
    /// least one matching instance.

    func containsViewController(ofKind kind: AnyClass) -> Bool
    {
        return self.viewControllers.contains(where: { $0.isKind(of: kind) })
    }
}

private class InteractiveNavigationPopRecognizer: NSObject, NSCopying, UIGestureRecognizerDelegate {

    weak var navigationController: UINavigationController?
    weak var originalPopDelegate: UIGestureRecognizerDelegate?

    required init(controller: UINavigationController?) {
        self.navigationController = controller
        self.originalPopDelegate = self.navigationController?.interactivePopGestureRecognizer?.delegate
    }

    required init(_ objectToCopy: InteractiveNavigationPopRecognizer) {
        self.navigationController = objectToCopy.navigationController
        self.originalPopDelegate = self.navigationController?.interactivePopGestureRecognizer?.delegate
    }

    override func responds(to aSelector: Selector!) -> Bool {
        if aSelector == #selector(gestureRecognizer(_:shouldReceive:)) {
            return true
        } else if aSelector == #selector(copy(with:)) {
            return true
        } else if let responds = originalPopDelegate?.responds(to: aSelector) {
            return responds
        }
        return false
    }

    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return originalPopDelegate
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return type(of: self).init(self)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let nav = navigationController, nav.isNavigationBarHidden, nav.viewControllers.count > 1 {
            return true
        } else if let result = originalPopDelegate?.gestureRecognizer?(gestureRecognizer, shouldReceive: touch) {
            return result
        }
        return false
    }
}

public extension UINavigationController {
    var rootViewController: UIViewController? {
        return self.viewControllers.first
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return visibleViewController?.preferredStatusBarStyle ?? self.parent?.preferredStatusBarStyle ?? UIStatusBarStyle.lightContent
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }

    override var childForStatusBarStyle: UIViewController? {
        return visibleViewController?.childForStatusBarStyle
    }
}

public extension UIViewController {
    private struct AssociatedKeys {
        static var topMostVisibleController: UInt8 = 1
    }

    private var topMostVisibleChildControllerHolder: TopMostVisibleChildControllerHolder? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.topMostVisibleController) as? TopMostVisibleChildControllerHolder }
        set { objc_setAssociatedObject(self, &AssociatedKeys.topMostVisibleController, newValue, .OBJC_ASSOCIATION_COPY) }
    }

    var topMostVisibleChildController: UIViewController? {
        return topMostVisibleChildControllerHolder?.controller
    }

    func setTopMost(visibleChildController childVc: UIViewController?) {
        topMostVisibleChildControllerHolder = TopMostVisibleChildControllerHolder.init(controller: childVc)
        self.setNeedsStatusBarAppearanceUpdate()
    }
}

public extension UINavigationController {

    func pushToViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }

    func popViewController(animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }

    func popToViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToViewController(viewController, animated: animated)
        CATransaction.commit()
    }

    func popToRootViewController(animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}

private class TopMostVisibleChildControllerHolder: NSObject, NSCopying {

    weak var controller: UIViewController?

    required init(controller: UIViewController?) {
        self.controller = controller
    }

    required init(_ objectToCopy: TopMostVisibleChildControllerHolder) {
        self.controller = objectToCopy.controller
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return type(of: self).init(self)
    }
}
