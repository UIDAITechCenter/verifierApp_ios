import UIKit

open class GradientView: UIView {

    public var gradientLayer: CAGradientLayer {
        layer as! CAGradientLayer
    }

    public override class var layerClass: AnyClass {
        CAGradientLayer.self
    }

}
