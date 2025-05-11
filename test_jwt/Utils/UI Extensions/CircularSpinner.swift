
import UIKit

class CircularSpinnerView: UIView {
    
    private var shapeLayers: [CAShapeLayer] = []
    private let numberOfSegments = 7
    private let animationDuration: CFTimeInterval = 2.0
    private let strokeLengthPercentage = 0.2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSpinner()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSpinner()
    }
    
    private func setupSpinner() {
        backgroundColor = .clear
        createSegments()
    }
    
    private func createSegments() {
        // Remove existing layers
        shapeLayers.forEach { $0.removeFromSuperlayer() }
        shapeLayers.removeAll()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let side = min(bounds.width, bounds.height)
        let radius = side / 2
        let strokeLength = strokeLengthPercentage * side
        let angleStep = (2.0 * .pi) / Double(numberOfSegments + 1)
        
        let path = UIBezierPath()
        
        for i in 1...numberOfSegments {
            let cornerX = center.x + radius * cos(Double(i) * angleStep)
            let cornerY = center.y + radius * sin(Double(i) * angleStep)
            let corner = CGPoint(x: cornerX, y: cornerY)
            let newX = center.x + (radius - strokeLength) * cos(Double(i) * angleStep)
            let newY = center.y + (radius - strokeLength) * sin(Double(i) * angleStep)
            path.move(to: corner)
            path.addLine(to: CGPoint(x: newX, y: newY))
        }
        
        // Create a CAShapeLayer for the path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor // Set stroke color to grey
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = nil // No fill, just strokes
        
        // Add the layer to the view's layer hierarchy
        layer.addSublayer(shapeLayer)
        shapeLayers.append(shapeLayer)
        
        startAnimation()
    }
    
    private func startAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi * 2
        rotationAnimation.duration = animationDuration
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.isRemovedOnCompletion = false
        
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func startAnimating() {
        layer.speed = 1.0
    }
    
    func stopAnimating() {
        layer.speed = 0.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createSegments() // Recreate segments when bounds change
    }
}
