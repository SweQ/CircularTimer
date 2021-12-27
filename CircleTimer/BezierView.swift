//
//  BezierView.swift
//  CircleTimer
//
//  Created by alexKoro on 4.12.21.
//

import UIKit

class BezierView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }
    
    var progressLayer = CAShapeLayer()
    var trackLayer = CAShapeLayer()
    
    var progressColor = UIColor.white {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor = UIColor.white {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    func createCircularPath() {
        let center = CGPoint(
            x: self.bounds.size.width / 2,
            y: self.bounds.size.height / 2
        )
        
        let circlePath = UIBezierPath(arcCenter: center, radius: (frame.width - 20) / 2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 20
        trackLayer.strokeEnd = 1
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 20
        //progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
        
    }
    
    func animationProgress(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = value
        
        
        progressLayer.add(animation, forKey: "animateProgress")
        progressLayer.strokeEnd = CGFloat(value)
    }
    
    override func draw(_ rect: CGRect) {
        createCircularPath()
    }
    

}
