//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    var player: AVAudioPlayer?
    

    
    @IBOutlet weak var bar: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        bar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
    
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
                    if self.secondPassed < totalTime {
                        
                        self.secondPassed += 1
                        bar.progress = Float(secondPassed) / Float(totalTime)
                                                
                    
                    } else {
                        self.userActivity?.invalidate()
                        titleLabel.text = "DONE"
                        playSound()
                    }
                }
        
                
            func playSound() {
                guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
                    return }
                let url = URL(fileURLWithPath: path)

                do {
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.play()
        
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }

