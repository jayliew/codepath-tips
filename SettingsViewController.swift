//
//  SettingsViewController.swift
//  tips
//
//  Created by Jay Liew on 1/12/16.
//  Copyright © 2016 Jay Liew. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        let defaults = NSUserDefaults.standardUserDefaults()
        
        tipControl.selectedSegmentIndex = defaults.integerForKey("default_tip_index")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    @IBAction func onTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "default_tip_index")
        defaults.synchronize()
    }
}
