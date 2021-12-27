//
//  ViewController2.swift
//  CircleTimer
//
//  Created by alexKoro on 5.12.21.
//

import UIKit

class ViewController2: UIViewController {
    
    var figureOne: CAShapeLayer!
    var figureTwo: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createShapes()
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapGestureHandler(sender:))
        )
        view.addGestureRecognizer(gesture)
    }
    
    @objc func tapGestureHandler(sender: UITapGestureRecognizer) {
        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        pathAnimation.fromValue = figureOne.path
       
        pathAnimation.toValue = figureTwo.path
        
        let fillColorAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.fillColor))
        fillColorAnimation.fromValue = UIColor.red.cgColor
        
        figureOne.path = figureTwo.path
        figureOne.fillColor = UIColor.green.cgColor
        fillColorAnimation.toValue = UIColor.green.cgColor
        
        
        let rotateAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        rotateAnimation.valueFunction = CAValueFunction(name: .rotateZ)
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = 4 * Float.pi
        
        let group = CAAnimationGroup()
        group.duration = 5
        group.animations = [pathAnimation, fillColorAnimation, rotateAnimation]
        figureOne.add(group, forKey: nil)
    }
    
    func createShapes() {
        figureOne = CAShapeLayer()
        figureOne.path = UIBezierPath(
            roundedRect: CGRect(
                x: self.view.frame.width / 2 - 50,
                y: self.view.frame.height / 2 - 50,
                width: 100,
                height: 100
            ),
            cornerRadius: 0
        ).cgPath
        figureOne.fillColor = UIColor.red.cgColor
        view.layer.addSublayer(figureOne)
        
        figureOne.frame = self.view.bounds
        
        figureTwo = CAShapeLayer()
        figureTwo.path = UIBezierPath(
            ovalIn: CGRect(
            x: self.view.frame.width / 2 - 150,
            y: self.view.frame.height / 2 - 150,
            width: 300,
            height: 300
            )
        ).cgPath
        figureTwo.fillColor = UIColor.green.cgColor
        //view.layer.addSublayer(figureTwo)
    }

}
