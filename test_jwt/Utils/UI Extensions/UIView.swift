
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if newValue?.responds(to: Selector("cgColor")) == true, let color = newValue?.cgColor {
                layer.borderColor = color
            }
        }
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }

    func autosize(maxWidth: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        let widthAnchorT = self.widthAnchor.constraint(equalToConstant: maxWidth)
        widthAnchorT.isActive = true
        self.layoutIfNeeded()
        self.sizeToFit()
        let size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        frame = CGRect(origin: .zero, size: size)
        translatesAutoresizingMaskIntoConstraints = true
        widthAnchorT.isActive = false
    }

    @discardableResult
    func fillSuperview() -> (left: NSLayoutConstraint, right: NSLayoutConstraint, top: NSLayoutConstraint, bottom: NSLayoutConstraint)? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            for constraint in [left, right, top, bottom] {
                constraint.isActive = true
            }
            return (left, right, top, bottom)
        }
        return nil
    }

    func fillSuperview(leading: CGFloat, trailing: CGFloat, top: CGFloat, bottom: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading)
            let right = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing)
            let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: top)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom)
            for constraint in [left, right, top, bottom] {
                constraint.isActive = true
            }
        }
    }

    @discardableResult
    func fillSuperview(height: NSLayoutConstraint) -> (left: NSLayoutConstraint, right: NSLayoutConstraint, top: NSLayoutConstraint, bottom: NSLayoutConstraint)? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            height.constant = self.frame.height
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            for constraint in [left, right, top, bottom] {
                constraint.isActive = true
            }
            return (left, right, top, bottom)
        }
        return nil
    }
    
    // MARK: Common UIView Animations

    // Animates the view by varying alpha value and finally hides the view.
    func fadeOut(animDuration: TimeInterval = 0.2, delay: TimeInterval = 0.0, options: UIView.AnimationOptions = [], completion: ((Bool) -> Swift.Void)? = nil) {

        func execute() {
            UIView.animate(withDuration: animDuration, delay: delay, options: options, animations: { [weak self] () in
                self?.alpha = 0.0
                self?.layoutIfNeeded()
            }, completion: { [weak self] (isCompleted) in
                self?.isHidden = true
                if let completionBlock = completion {
                    completionBlock(isCompleted)
                }
            })
        }

        DispatchQueue.onMainIfRequired {
            execute()
        }

    }

    /**
     Animates the view by varying alpha value.
     */
    func fadeIn(
        finalAlpha: CGFloat = 1.0,
        animDuration: TimeInterval = 0.2,
        delay: TimeInterval = 0.0,
        options: UIView.AnimationOptions = [],
        layoutView: Bool = true,
        completion: ((Bool) -> Void)? = nil
    ) {

        isHidden = false
        alpha = 0.0

        UIView.animate(withDuration: animDuration, delay: delay, options: options, animations: { [weak self] () in
            self?.alpha = finalAlpha
            if layoutView {
                self?.layoutIfNeeded()
            }
        }, completion: completion)
    }

    /*
     Shake the view for a
     */
    func shake(duration: Float = 0.2, values: [Double] = [-10.0, 10.0, -7.5, 7.5, -5.0, 5.0, -2.5, 2.5, 0.0]) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = CFTimeInterval(duration)
        animation.repeatCount = 1
        animation.values = values
        layer.add(animation, forKey: "shake")
    }

    func mask(_ rect: CGRect, invert: Bool = false) {
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        if (invert) {
            path.addRect(bounds)
        }
        path.addRect(rect)
        maskLayer.path = path
        if (invert) {
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        }
        // Set the mask of the view.
        layer.mask = maskLayer
    }

}

open class TouchPassThroughView: UIView {
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let eventView = super.hitTest(point, with: event)
        return eventView == self ? nil : eventView
    }
}
