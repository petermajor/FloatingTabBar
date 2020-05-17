import UIKit

class BackgroundGradientView: UIView {
    
    var direction: GradientDirection = .topToBottom {
        didSet {
            guard let gradientLayer = gradientLayer else { return }
            let (startPoint, endPoint) = direction.startAndEndPoints()
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
        }
    }

    var colors: [UIColor] = [.white, .black] {
       didSet {
           guard let gradientLayer = gradientLayer else { return }
           gradientLayer.colors = colors.map { $0.cgColor as Any }
       }
    }

    var cornerRadius: CGFloat = 0 {
      didSet {
          guard let gradientLayer = gradientLayer else { return }
          gradientLayer.cornerRadius = cornerRadius
      }
    }
    
    var locations: [Double]? = nil {
         didSet {
             guard let gradientLayer = gradientLayer else { return }
             gradientLayer.locations = locations?.map { NSNumber(value: $0) }
         }
    }

    private weak var gradientLayer: CAGradientLayer?
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        guard gradientLayer == nil else {
            updateGadientLayerFrame()
            return
        }
        
        recreateGradientLayer()
    }
    
    private func updateGadientLayerFrame() {
        gradientLayer?.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
    }
    
    private func recreateGradientLayer() {
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = createGradientLayer()
        layer.insertSublayer(gradientLayer!, at: 0)
    }

    private func createGradientLayer() -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.colors = colors.map { $0.cgColor as Any }
        let (startPoint, endPoint) = direction.startAndEndPoints()
        layer.startPoint = startPoint
        layer.endPoint = endPoint
        layer.cornerRadius = cornerRadius
        layer.locations = locations?.map { NSNumber(value: $0) }
        return layer
    }
}

enum GradientDirection {
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
    case topLeftToBottomRight
    case topRightToBottomLeft
    case bottomLeftToTopRight
    case bottomRightToTopLeft
    case custom(Int)

    func startAndEndPoints() -> (startPoint: CGPoint, endPoint: CGPoint) {
        switch self {
        case .topToBottom:
            return (CGPoint(x: 0.5, y: 0.0), CGPoint(x: 0.5, y: 1.0))
        case .bottomToTop:
            return (CGPoint(x: 0.5, y: 1.0), CGPoint(x: 0.5, y: 0.0))
        case .leftToRight:
            return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
        case .rightToLeft:
            return (CGPoint(x: 1.0, y: 0.5), CGPoint(x: 0.0, y: 0.5))
        case .topLeftToBottomRight:
            return (CGPoint.zero, CGPoint(x: 1.0, y: 1.0))
        case .topRightToBottomLeft:
            return (CGPoint(x: 1.0, y: 0.0), CGPoint(x: 0.0, y: 1.0))
        case .bottomLeftToTopRight:
            return (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0))
        case .bottomRightToTopLeft:
            return (CGPoint(x: 1.0, y: 1.0), CGPoint(x: 0.0, y: 0.0))
        case .custom(let angle):
            return startAndEndPoints(from: angle)
        }
    }
    
    private func startAndEndPoints(from angle: Int) -> (startPoint:CGPoint, endPoint:CGPoint) {
        // Set default points for angle of 0°
        var startPointX: CGFloat = 0.5
        var startPointY: CGFloat = 1.0

        // Define point objects
        var startPoint: CGPoint
        var endPoint: CGPoint

        // Define points
        switch true {
        // Define known points
        case angle == 0:
            startPointX = 0.5
            startPointY = 1.0
        case angle == 45:
            startPointX = 0.0
            startPointY = 1.0
        case angle == 90:
            startPointX = 0.0
            startPointY = 0.5
        case angle == 135:
            startPointX = 0.0
            startPointY = 0.0
        case angle == 180:
            startPointX = 0.5
            startPointY = 0.0
        case angle == 225:
            startPointX = 1.0
            startPointY = 0.0
        case angle == 270:
            startPointX = 1.0
            startPointY = 0.5
        case angle == 315:
            startPointX = 1.0
            startPointY = 1.0
        // Define calculated points
        case angle > 315 || angle < 45:
            startPointX = 0.5 - CGFloat(tan(degreesToRads(angle)) * 0.5)
            startPointY = 1.0
        case angle > 45 && angle < 135:
            startPointX = 0.0
            startPointY = 0.5 + CGFloat(tan(degreesToRads(90) - degreesToRads(angle)) * 0.5)
        case angle > 135 && angle < 225:
            startPointX = 0.5 - CGFloat(tan(degreesToRads(180) - degreesToRads(angle)) * 0.5)
            startPointY = 0.0
        case angle > 225 && angle < 359:
            startPointX = 1.0
            startPointY = 0.5 - CGFloat(tan(degreesToRads(270) - degreesToRads(angle)) * 0.5)
        default: break
        }
        // Build return CGPoints
        startPoint = CGPoint(x: startPointX, y: startPointY)
        endPoint = opposite(startPoint)
        // Return CGPoints
        return (startPoint, endPoint)
    }
    
    private func degreesToRads(_ value: Int) -> Double {
        return (Double(value) * .pi / 180)
    }
    
    private func opposite(_ value: CGPoint) -> CGPoint {
        // Create New Point
        var oppositePoint = CGPoint()
        // Get Origin Data
        let originXValue = value.x
        let originYValue = value.y
        // Convert Points and Update New Point
        oppositePoint.x = 1.0 - originXValue
        oppositePoint.y = 1.0 - originYValue
        return oppositePoint
    }
}
