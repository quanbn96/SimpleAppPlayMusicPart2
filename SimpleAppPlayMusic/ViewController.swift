//
//  ViewController.swift
//  SimpleAppPlayMusic
//
//  Created by Quan on 6/23/16.
//  Copyright © 2016 MyStudio. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var sld_Volume: UISlider!
    @IBOutlet weak var btn_Play: UIButton!
    @IBOutlet weak var lbl_TimeLeft: UILabel!
    @IBOutlet weak var lbl_TimeTotal: UILabel!
    @IBOutlet weak var sld_Duration: UISlider!
    @IBOutlet weak var switch_Repeat: UISwitch!
    
    
    var checkBtnPlay = true
    var audio = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: ".mp3")!))
        
        audio.delegate = self
        audio.prepareToPlay()
        addThumbImgForSlider()
        audio.numberOfLoops = 0
        lbl_TimeTotal.text = String(format: "%2.2f", self.audio.duration / 60)
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
        
    }
    
    func updateTimeLeft() {
        self.lbl_TimeLeft.text = String(format: "%2.2f", self.audio.currentTime / 60)
        self.sld_Duration.value = Float(audio.currentTime / audio.duration)
    }
    
    func addThumbImgForSlider() {
        sld_Volume.setThumbImage(UIImage(named: "thumb.png"), forState: .Normal)
        sld_Volume.setThumbImage(UIImage(named: "thumbHightLight.png"), forState: .Highlighted)
    }
    
    @IBAction func action_Play(sender: AnyObject) {
        if  checkBtnPlay == true {
            btn_Play.setBackgroundImage(UIImage(named: "pause.png"), forState: .Normal)
            audio.play()
            checkBtnPlay = false
            
        } else {
            
            btn_Play.setBackgroundImage(UIImage(named: "play.png"), forState: .Normal)
            audio.stop()
            checkBtnPlay = true
        }
    }
    
    @IBAction func sld_Action_Duration(sender: UISlider) {
        audio.currentTime = Double(sender.value) * audio.duration
    }
    @IBAction func sld_Vol(sender: UISlider) {
        audio.volume = sender.value
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if switch_Repeat.on == true {
            audio.prepareToPlay()
            audio.play()
        } else {
            btn_Play.setBackgroundImage(UIImage(named: "play.png"), forState: .Normal)
        }
    }


}

