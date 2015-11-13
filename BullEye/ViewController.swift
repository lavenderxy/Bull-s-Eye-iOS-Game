//
//  ViewController.swift
//  BullEye
//
//  Created by 闫 欣宇 on 15-11-11.
//  Copyright (c) 2015年 XinyuYan. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var _currentValue: Int = 0
    var _targetValue: Int = 0
    var _score = 0
    var _round = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        currentValue = lroundf(slider.value)
//        targetValue = 1+Int(arc4random_uniform(100))
        
        //initiate the slider
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft"){
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight"){
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
        
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert() {
        let difference = abs(_targetValue - _currentValue)
        var points = 100 - difference
        
        var title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        }else if difference < 5 {
            title = "You almost had it!"
            points += 50
        }else if difference < 10 {
            title = "Pretty good!"
        }else {
            title = "Not even close..."
        }
        
        _score += points
        
        let message = "You scored: \(points) points"
        
        let alert = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK",
            style: .Default,
            handler: { action in
                        self.startNewRound()
                        self.updateLabels()
                    })
        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(slider: UISlider){
        //println("The value of the slider is now: \(slider.value)")
        _currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver(){
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.addAnimation(transition, forKey: nil)
    }
    
    func startNewRound(){
        _round += 1
        _targetValue = 1+Int(arc4random_uniform(100))
        _currentValue = 50
        slider.value = Float(_currentValue)
    }
    
    func updateLabels(){
        targetLabel.text = String(_targetValue)
        scoreLabel.text = String(_score)
        roundLabel.text = String(_round)
    }
    
    func startNewGame(){
        _round = 0
        _score = 0
        startNewRound()
    }

}

