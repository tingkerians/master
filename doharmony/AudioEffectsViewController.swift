//
//  AudioEffectsViewController.swift
//  doharmony
//
//  Created by eliakim on 3/18/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class AudioEffectsViewController: UIViewController {
    @IBAction func closeButton(sender: AnyObject) {
        print("close")
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    @IBAction func close_reverb_btn(sender: AnyObject) {
    }
    @IBOutlet weak var reverb_picker: UIPickerView!
    @IBOutlet weak var close_reverbBtn: UIButton!

    @IBAction func reverbSetting(sender: AnyObject) {
        self.close_reverbBtn.hidden = false
        self.reverb_picker.hidden = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.reverb_picker.setValue(UIColor.whiteColor(),forKeyPath: "textColor")
//        self.close_reverbBtn.hidden = true
//        self.reverb_picker.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
