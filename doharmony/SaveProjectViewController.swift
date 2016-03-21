//
//  SaveProjectViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 3/10/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class SaveProjectViewController: UIViewController {
 

   

    
    @IBAction func closeButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBOutlet weak var makePrivateButton: UIButton!
    @IBOutlet weak var makePublicButton: UIButton!
    @IBOutlet weak var allowButton: UIButton!
    var checkBox : Bool?
    
    @IBAction func makePrivateButton(sender: AnyObject) {
        checkPrivateImageButton()
        uncheckPublicImageButton()
        
        var Image : UIImage!
        Image = UIImage(named: "checkbox_uncheck")
        allowButton.setImage(Image, forState: .Normal)
    }
    
    @IBAction func makePublicButton(sender: AnyObject) {
        checkBox = true
        checkPublicImageButton()
        uncheckPrivateImageButton()
        allowTrackImageButton()
        
        
    }
    

    @IBAction func allowButton(sender: AnyObject) {
        allowTrackImageButton()
    }
    
    
    func checkPrivateImageButton() {
        var Image : UIImage!
        Image = UIImage(named: "radio_check")
        makePrivateButton.setImage(Image, forState: .Normal)
    }
    
    func uncheckPrivateImageButton() {
        var Image : UIImage!
        Image = UIImage(named: "radio_uncheck")
        makePrivateButton.setImage(Image, forState: .Normal)
    }
    
    func checkPublicImageButton() {
        var Image : UIImage!
        Image = UIImage(named: "radio_check")
        makePublicButton.setImage(Image, forState: .Normal)
    }
    
    func uncheckPublicImageButton() {
        var Image : UIImage!
        Image = UIImage(named: "radio_uncheck")
        makePublicButton.setImage(Image, forState: .Normal)
    }
    
    func allowTrackImageButton() {
        var Image : UIImage!
        if checkBox == true {
            Image = UIImage(named: "checkbox_check")
            checkBox = false
        } else {
            Image = UIImage(named: "checkbox_uncheck")
            checkBox = true
        }
        
        allowButton.setImage(Image, forState: .Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func didSelectButton(aButton: UIButton?) {
        print(aButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
