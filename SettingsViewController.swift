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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "default_tip_index")
        darkSwitch.isOn = defaults.bool(forKey: "dark_theme")
        
        if defaults.bool(forKey: "dark_theme") == true {
            
            self.view.backgroundColor = UIColor(red:0x91, green:0xA4, blue:0xD0)
            
            tipControl.tintColor = UIColor(red:0xF8, green: 0xDB, blue: 0xDA)
            tipControl.backgroundColor = UIColor(red:0x91, green:0xA4, blue:0xD0)
            
            self.darkThemeLabel.textColor = UIColor.white
            self.tipRateLabel.textColor = UIColor.white
        }else{
            self.view.backgroundColor = UIColor(red:0xF8, green: 0xDB, blue: 0xDA)
            
            tipControl.tintColor = UIColor(red:0x91, green:0xA4, blue:0xD0)
            tipControl.backgroundColor = UIColor.white
            tipControl.layer.cornerRadius = 3
            tipControl.layer.shadowColor = UIColor.black.cgColor
            tipControl.layer.shadowOffset = CGSize(width: 3, height: 3)
            tipControl.layer.shadowOpacity = 0.3
            tipControl.layer.shadowRadius = 3.0
            
            darkSwitch.tintColor = UIColor.white
            
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
            
            self.view.backgroundColor = UIColor(red:0x91, green:0xA4, blue:0xD0)

            tipControl.tintColor = UIColor(red:0xF8, green: 0xDB, blue: 0xDA)
            tipControl.backgroundColor = UIColor(red:0x91, green:0xA4, blue:0xD0)

            self.darkThemeLabel.textColor = UIColor.white
            self.tipRateLabel.textColor = UIColor.white
            
        }else{
            self.view.backgroundColor = UIColor(red:0xF8, green: 0xDB, blue: 0xDA)
            
            tipControl.tintColor = UIColor(red:0x91, green:0xA4, blue:0xD0)
            tipControl.backgroundColor = UIColor.white
            tipControl.layer.cornerRadius = 3
            tipControl.layer.shadowColor = UIColor.black.cgColor
            tipControl.layer.shadowOffset = CGSize(width: 3, height: 3)
            tipControl.layer.shadowOpacity = 0.3
            tipControl.layer.shadowRadius = 3.0
            
            darkSwitch.tintColor = UIColor.white
            
            self.darkThemeLabel.textColor = UIColor.black
            self.tipRateLabel.textColor = UIColor.black
        }
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
