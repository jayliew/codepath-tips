//
//  ViewController.swift
//  tips
//
//  Created by Jay Liew on 1/6/16.
//  Copyright © 2016 Jay Liew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipTextLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var billAmountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = defaults.integerForKey("default_tip_index")
        onEditingChanged(billField)
        
        if defaults.boolForKey("dark_theme") == true {
            self.view.backgroundColor = UIColor(red: 0.0235, green: 0, blue: 0.3765, alpha: 1.0)
            billField.backgroundColor = UIColor(red: 0.0235, green: 0, blue: 0.3765, alpha: 1.0)
            
            tipTextLabel.textColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            totalTextLabel.textColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            separatorView.backgroundColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            billField.textColor = UIColor.whiteColor()
            billField.backgroundColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            billAmountLabel.textColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            tipLabel.textColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            totalLabel.textColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
        }else{
            self.view.backgroundColor = UIColor.whiteColor()
            billField.backgroundColor = UIColor.whiteColor()
            
            tipTextLabel.textColor = UIColor.blackColor()
            totalTextLabel.textColor = UIColor.blackColor()
            separatorView.backgroundColor = UIColor.blackColor()
            billField.textColor = UIColor.blackColor()
            billField.backgroundColor = UIColor.whiteColor()
            billAmountLabel.textColor = UIColor.blackColor()
            tipLabel.textColor = UIColor.blackColor()
            totalLabel.textColor = UIColor.blackColor()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let billAmount = NSString(string: billField.text!).doubleValue
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
//        tipLabel.text = "$\(tip)"
  //      totalLabel.text = "$\(total)"
        
        tipLabel.text = String(format: "$%.2f",tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

