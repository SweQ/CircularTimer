//
//  CircleView.swift
//  CircleTimer
//
//  Created by alexKoro on 7.12.21.
//

import UIKit

class CircleView: UIView {
    
    var progressCircle = CAShapeLayer()
    var backgroundCircle = CAShapeLayer()
    
    let lineWidth: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        progressCircle.strokeEnd = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        progressCircle.strokeEnd = 0
    }
    
    func setupCircles() {
        let center = CGPoint(
            x: self.bounds.size.width / 2,
            y: self.bounds.size.height / 2
        )
        let radius = ((bounds.width) - lineWidth) / 2
        let startAngle = (3 * CGFloat.pi) / 2
        let endAngle = (3 * CGFloat.pi) / 2.00001
        
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        
        progressCircle.path = path.cgPath
        backgroundCircle.path = path.cgPath
        
        setupStyle(for: progressCircle, color: .systemMint)
        setupStyle(for: backgroundCircle, color: .systemGray5)

        layer.addSublayer(backgroundCircle)
        layer.addSublayer(progressCircle)
        
    }
    
    func setupStyle(for circle: CAShapeLayer, color: UIColor) {
        circle.lineWidth = lineWidth
        circle.strokeColor = color.cgColor
        circle.fillColor = UIColor.clear.cgColor
        circle.lineCap = .round
    }
    
    func animateCircle(duration: Int, add stroke: Double) {
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        animation.fromValue = progressCircle.strokeEnd
        progressCircle.strokeEnd = stroke
        animation.toValue = progressCircle.strokeEnd
        animation.duration = CFTimeInterval(duration)
        progressCircle.add(animation, forKey: nil)
    }

}
