//
//  MetronomeViewController.swift
//  doharmony
//
//  Created by Daryl Super Duper Handsum on 10/03/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class MetronomeViewController: UIViewController {
    
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var bpmlabel: UILabel!
    @IBOutlet weak var metronomeSwitch: UISwitch!
    
    @IBOutlet weak var oneFourth: UIButton!
    @IBOutlet weak var twoFourth: UIButton!
    @IBOutlet weak var threeFourth: UIButton!
    @IBOutlet weak var fourFourth: UIButton!
    var timeSignatureButtons:[UIButton] = []
    
    var timeSignature:Double = 1
    var beatPerMinute:Double = 60
    var timer:timerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeSignatureButtons = [oneFourth,twoFourth,threeFourth,fourFourth]
        for button in timeSignatureButtons{
            let tap = UITapGestureRecognizer(target: self, action: "changeTimeSignature:")
            button.addGestureRecognizer(tap)
        }
        refreshTimer()
    }

    @IBAction func closeWindow(sender: AnyObject) {
        timer.stop()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func changeTimeSignature(button:UITapGestureRecognizer){
        timeSignature = Double(button.view!.tag)
        refreshTimer()
    }
    
    func refreshTimer(){
        bpmlabel.text = "\(Int(bpmSlider.value)) bpm"
        beatPerMinute = Double(bpmSlider.value)
        if timer.isRunning{
            timer.stop()
        }
        timer.setupMetronome(beatPerMinute, timeSignature: timeSignature)
        timer.start()
    }
    @IBAction func changeBpmLabel(sender: AnyObject) {
        bpmlabel.text = "\(Int(bpmSlider.value)) bpm"
    }
    @IBAction func changeBpm(sender: AnyObject) {
        refreshTimer()
    }
    @IBAction func subtractBpm(sender: AnyObject) {
        bpmSlider.value--
        refreshTimer()
    }
    @IBAction func addBpm(sender: AnyObject) {
        bpmSlider.value++
        refreshTimer()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
