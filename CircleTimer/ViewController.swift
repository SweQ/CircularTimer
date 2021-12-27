//
//  ViewController.swift
//  CircleTimer
//
//  Created by alexKoro on 4.12.21.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    let startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 84)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shapeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .gray
        imageView.backgroundColor = .black
        return imageView
    }()
    
    let shapeLayer = CAShapeLayer()
    var timer = Timer()
    var timerIsActive = false {
        willSet {
            if newValue {
                startButton.setTitle("Pause", for: .normal)
            } else {
                timer.invalidate()
                startButton.setTitle("Start", for: .normal)
            }
        }
    }
    
    var durationTimer = 10 {
        didSet {
            timeLabel.text = "\(durationTimer)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupShapeView()
        setupTimeLabel()
        durationTimer = 10
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animationCircular()
    }
    
    func setupButton() {
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            startButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    }
    
    func setupTimeLabel() {
        shapeView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.widthAnchor.constraint(equalToConstant: 100),
            timeLabel.heightAnchor.constraint(equalToConstant: 100),
            timeLabel.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor)
            
        ])
    }
    
    func setupShapeView() {
        view.addSubview(shapeView)
        NSLayoutConstraint.activate([
            shapeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            shapeView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            shapeView.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -50),
            shapeView.heightAnchor.constraint(equalTo: shapeView.widthAnchor)
        ])
    }
    
    func animationCircular() {
        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
        let radius = shapeView.frame.width / 2 - 30
        let endAngle = CGFloat.pi / 2
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle:  startAngle, endAngle: endAngle, clockwise: false)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 27
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeView.layer.addSublayer(shapeLayer)
    }
    
    func basicAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 0
        animation.duration = CFTimeInterval(durationTimer)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = true
        shapeLayer.add(animation, forKey: "animation")
    }
    
    @objc func timerActionBlock() {
        guard durationTimer > 1 else {
            durationTimer = 10
            timerIsActive = false
            return
        }
        durationTimer -= 1
    }
    
    @objc func startButtonPressed() {
        if timerIsActive {
            timerIsActive = !timerIsActive
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerActionBlock), userInfo: nil, repeats: true)
            basicAnimation()
            timerIsActive = true
        }
    }


}

