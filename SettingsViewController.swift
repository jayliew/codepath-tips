//
//  SettingsViewController.swift
//  tips
//
//  Created by Jay Liew on 1/12/16.
//  Copyright © 2016 Jay Liew. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{

    
    // MARK: Outlets
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var darkSwitch: UISwitch!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var tipRateLabel: UITextField!
    @IBOutlet weak var darkThemeLabel: UILabel!
    
    // MARK: Properties
    
    let lightBlue = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
    let darkBlue = UIColor(red: 0.0235, green: 0, blue: 0.3765, alpha: 1.0)
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        
        tipControl.selectedSegmentIndex = defaults.integerForKey("default_tip_index")
        darkSwitch.on = defaults.boolForKey("dark_theme")
        
        if defaults.boolForKey("dark_theme") == true {
            self.darkThemeLabel.textColor = lightBlue
            self.tipRateLabel.textColor = lightBlue
            self.view.backgroundColor = darkBlue
        }else{
            self.view.backgroundColor = UIColor.whiteColor()
            self.darkThemeLabel.textColor = UIColor.blackColor()
            self.tipRateLabel.textColor = UIColor.blackColor()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "default_tip_index")
        defaults.synchronize()

    }
    
    @IBAction func darkValueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(darkSwitch.on, forKey: "dark_theme")
        defaults.synchronize()
        if defaults.boolForKey("dark_theme") == true {
            self.view.backgroundColor = darkBlue
            self.darkThemeLabel.textColor = lightBlue
            self.tipRateLabel.textColor = lightBlue
        }else{
            self.view.backgroundColor = UIColor.whiteColor()
            self.darkThemeLabel.textColor = UIColor.blackColor()
            self.tipRateLabel.textColor = UIColor.blackColor()
        }

    }
    
    @IBAction func onTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
