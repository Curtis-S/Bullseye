//
//  ViewController.swift
//  Bullseye
//
//  Created by curtis scott on 29/01/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue =  0
    var score = 0
    var round = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right:   14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewRound()
    }
    
    func startNewRound(){
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        updateLabels()
        
    }
    @IBAction func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    @IBAction func showAlert(){
        let difference = abs(targetValue-currentValue)
        var points = 100 - difference

        let title:String
        if difference == 0{
            title = "Spot on"
            points += 100
        }else if difference < 5 {
            title = "almost had it "
            points += 50
        }else if difference < 15 {
            title = "pretty good"
            points += 25
        }else {
            title = "not even close"
        }
        
        score += points
        let message = "you scored: \(points) points"
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action  = UIAlertAction(title: "OK", style: .default, handler: {_ in self.startNewRound()})
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
       
    }

    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
    }

}

