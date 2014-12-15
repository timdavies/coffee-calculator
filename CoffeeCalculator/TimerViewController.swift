//
//  TimerViewController.swift
//  CoffeeCalculator
//
//  Created by Tim Davies on 15/12/2014.
//  Copyright (c) 2014 Tim Davies. All rights reserved.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {
    @IBOutlet weak var decrementTimerButton: UIButton!
    @IBOutlet weak var incrementTimerButton: UIButton!
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var timerText: UILabel!
    
    var nstimer:NSTimer? = nil
    var timer = 60 * 4
    var lastTimer = 60 * 4
    var timerRunning = false
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0xFAFAFA)
        renderTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func startTimer(sender: AnyObject) {
        if (!timerRunning) {
            timerRunning = true
            lastTimer = timer
            startTimerButton.setTitle("Reset", forState: UIControlState.Normal)
            
            decrementTimerButton.enabled = false
            incrementTimerButton.enabled = false
            
            nstimer = NSTimer.scheduledTimerWithTimeInterval(
                1.0,
                target: self,
                selector: Selector("timerTick"),
                userInfo: nil,
                repeats: true
            )
        } else {
            timerRunning = false
            startTimerButton.setTitle("Start Timer", forState: UIControlState.Normal)
            decrementTimerButton.enabled = true
            incrementTimerButton.enabled = true
            nstimer?.invalidate()
            timer = lastTimer
            renderTimer()
        }
    }
    
    @IBAction func incrementTimer(sender: AnyObject) {
        timer += 15
        checkTimerChangeButtons()
        renderTimer()
    }
    
    @IBAction func decrementTimer(sender: AnyObject) {
        timer -= 15
        checkTimerChangeButtons()
        renderTimer()
    }
    
    func checkTimerChangeButtons() {
        if (timer + 15 > 60 * 5) {
            incrementTimerButton.enabled = false
        } else {
            incrementTimerButton.enabled = true
        }
        
        if (timer - 15 < 60 * 2) {
            decrementTimerButton.enabled = false
        } else {
            decrementTimerButton.enabled = true
        }
    }
    
    func timerTick() {
        timer--
        
        if (timer == 0) {
            nstimer?.invalidate()
            
            let soundURL = NSBundle.mainBundle().URLForResource("timer", withExtension: "mp3")
            audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
            
            var alert = UIAlertController(
                title: "Timer done",
                message: nil,
                preferredStyle: UIAlertControllerStyle.Alert
            )
            
            let alertAction = UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Default,
                handler: { action in
                    self.audioPlayer.stop()
                }
            )
            alert.addAction(alertAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        renderTimer()
    }
    
    func renderTimer() {
        var tmp = timer
        
        var minutes = 0
        while tmp >= 60 {
            tmp -= 60
            minutes += 1
        }
        
        var seconds = String(tmp)
        if (tmp < 10) {
            seconds = "0" + seconds
        }
        
        timerText.text = "\(minutes):\(seconds)"
    }
}
