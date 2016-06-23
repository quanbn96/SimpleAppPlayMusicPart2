//
//  ViewController.swift
//  SimpleAppPlayMusic
//
//  Created by Quan on 6/23/16.
//  Copyright © 2016 MyStudio. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var sld_Volume: UISlider!
    @IBOutlet weak var btn_Play: UIButton!
    var checkBtnPlay = true
    var audio = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: ".mp3")!))
        audio.prepareToPlay()
        addThumbImgForSlider()
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
    
    @IBAction func sld_Vol(sender: UISlider) {
        print("\(sender.value)")
        audio.volume = sender.value
    }
    


}

