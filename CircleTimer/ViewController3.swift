//
//  ViewController3.swift
//  CircleTimer
//
//  Created by alexKoro on 6.12.21.
//

import UIKit

class ViewController3: UIViewController {

    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var stroke: Double = 0
    
    var seconds: Int = 0 {
        didSet {
            timeLabel.text = "\(seconds)"
        }
    }
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimeLabel()
        setupButton()
        seconds = 10
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        circleView.setupCircles()
    }
    
    func startTimer() {
        seconds = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        
    }
    
    func setupButton() {
        startButton.layer.cornerRadius = 20
        startButton.backgroundColor = .systemMint
    }
    
    func setupTimeLabel() {
        timeLabel.font = .systemFont(ofSize: 120)
        timeLabel.baselineAdjustment = .alignCenters
        timeLabel.text = "00"
        timeLabel.textColor = .gray
        timeLabel.adjustsFontSizeToFitWidth = true
    }
    
    @objc func timerTick() {
        guard seconds > 0
        else {
            timer.invalidate()
            circleView.progressCircle.strokeEnd = 0
            stroke = 0
            startButton.setTitle("START", for: .normal)
            return
        }
        stroke += 1/9
        circleView.animateCircle(duration: 1, add: stroke)
        seconds -= 1
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        guard !timer.isValid else {
            stroke = 0
            timer.invalidate()
            startButton.setTitle("START", for: .normal)
            return
        }
        startButton.setTitle("STOP", for: .normal)
        startTimer()
    }
    
}
