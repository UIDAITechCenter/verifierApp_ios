
import UIKit

public enum GradientDirection: String {
    case leftToRight = "Left_Right"
    case topToBottom = "Top_Bottom"
    case topLeftToBottomRight = "TopLeft_BottomRight"
    case bottomLeftToTopRight = "BottomLeft_TopRight"
    case customDirection1 = "CustomDirection1"
}

struct UIHelper {
    public static func keyWindowSafeAreaInsets() -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                return window.safeAreaInsets
            }
        }
        return UIEdgeInsets.zero
    }

    static func addChildViewController(_ childVC: UIViewController, onParent parentVC: UIViewController) {
        addChildViewController(childVC, parentViewController: parentVC, onParentView: parentVC.view)
    }
    
    public static func addChildViewController(_ childVC: UIViewController, parentViewController parentVC: UIViewController, onParentView parentView: UIView, disableParentAccessibility: Bool = true) {

        childVC.view.layoutIfNeeded()
        parentView.addSubview(childVC.view)
        parentVC.addChild(childVC)
        childVC.didMove(toParent: parentVC)
        if disableParentAccessibility {
            if let childVCView = childVC.view {
                parentVC.view.accessibilityElements = [childVCView]
            }
        }
    }

    public static func removeChildViewController(childVC: UIViewController) {
        childVC.parent?.view.accessibilityElements = nil
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }
    
    public static func getGradientStartAndEndPoints(direction: String) -> (start: CGPoint, end: CGPoint) {
        var gradientPoints: (CGPoint, CGPoint) = (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
        guard let directionType = GradientDirection(rawValue: direction) else {
            return gradientPoints
        }

        switch directionType {
        case .leftToRight:
            gradientPoints = (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
        case .topToBottom:
            gradientPoints = (CGPoint(x: 0.5, y: 0.0), CGPoint(x: 0.5, y: 1.0))
        case .topLeftToBottomRight:
            gradientPoints = (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 1.0, y: 1.0))
        case .bottomLeftToTopRight:
            gradientPoints = (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0))
        case .customDirection1:
            gradientPoints = (CGPoint(x: 0.25, y: 0.0), CGPoint(x: 0.75, y: 1.0))
        }

        return gradientPoints
    }
    /**
     Sets corner radius of a view. This work only on iOS 11.0 and later.
     */
    @available(iOS 11.0, *)
    public static func round(corners: CACornerMask, view: UIView, radius: CGFloat = 8) {
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
        view.layer.maskedCorners = corners
    }

    /**
     Sets top corner radius of a view. This work only on iOS 11.0 and later.
    */
    public static func setTopCornerRadius(view: UIView, radius: CGFloat = 8) {
        if #available(iOS 11.0, *) {
            view.clipsToBounds = true
            view.layer.cornerRadius = radius
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }

    /**
     Sets bottom corner radius of a view. This work only on iOS 11.0 and later.
     */
    public static func setBottomCornerRadius(view: UIView, radius: CGFloat = 8) {
        if #available(iOS 11.0, *) {
            view.clipsToBounds = true
            view.layer.cornerRadius = radius
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    public static func generateHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }

    public static func generateSelectionHaptic() {
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.prepare()
        feedbackGenerator.selectionChanged()
    }
}
