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
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var player:AVAudioPlayer?=nil
    @IBOutlet weak var progressView: UIProgressView!
    var hardnessList=["Soft":1,"Medium":7,"Hard":9]
    var secondsRemianing=60
    var totaltime=0
    var timer:Timer?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player=AVAudioPlayer.init()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let text=sender.currentTitle
        print(text)
        secondsRemianing=hardnessList[text!]!*60
        totaltime=secondsRemianing
        timer?.invalidate()
        print(hardnessList[text!])
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
     
        
    }
    @objc func updateTimer(){
        if(secondsRemianing>0){
            secondsRemianing-=1
            progressView.isHidden=false
            print("\(secondsRemianing) seconds.")
            let percent = 100-( secondsRemianing*100/totaltime)
            print(percent)
            print(Float(percent)/Float(100))
            progressView?.progress=Float(percent)/Float(100)
        }else{
            progressView.isHidden=true
            timer?.invalidate()
            timerLabel.text="Time is Over"
            timerLabel.isHidden=false
            playAlarmsound(name: "alarm_sound")
        }
    }
    func playAlarmsound(name:String){
        let url=Bundle.main.url(forResource: name, withExtension: "mp3")
        player=try!AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}
