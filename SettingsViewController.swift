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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "default_tip_index")
        darkSwitch.isOn = defaults.bool(forKey: "dark_theme")
        
        if defaults.bool(forKey: "dark_theme") == true {
            self.darkThemeLabel.textColor = lightBlue
            self.tipRateLabel.textColor = lightBlue
            self.view.backgroundColor = darkBlue
        }else{
            self.view.backgroundColor = UIColor.white
            self.darkThemeLabel.textColor = UIColor.black
            self.tipRateLabel.textColor = UIColor.black
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func onValueChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(tipControl.selectedSegmentIndex, forKey: "default_tip_index")
        defaults.synchronize()

    }
    
    @IBAction func darkValueChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(darkSwitch.isOn, forKey: "dark_theme")
        defaults.synchronize()
        if defaults.bool(forKey: "dark_theme") == true {
            self.view.backgroundColor = darkBlue
            self.darkThemeLabel.textColor = lightBlue
            self.tipRateLabel.textColor = lightBlue
        }else{
            self.view.backgroundColor = UIColor.white
            self.darkThemeLabel.textColor = UIColor.black
            self.tipRateLabel.textColor = UIColor.black
        }

    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
