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
    @IBOutlet weak var onePerson: UIImageView!
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
        
        if defaults.boolForKey("dark_theme") == true {
            self.view.backgroundColor = UIColor(red: 0.0235, green: 0, blue: 0.3765, alpha: 1.0)
            billField.backgroundColor = UIColor(red: 0.0235, green: 0, blue: 0.3765, alpha: 1.0)
            tipTextLabel.textColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            billField.textColor = UIColor.whiteColor()
            billField.backgroundColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            tipLabel.textColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            //totalLabel.textColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            totalLabel.textColor = UIColor.whiteColor()
        }else{
            self.view.backgroundColor = UIColor.whiteColor()
            billField.backgroundColor = UIColor.whiteColor()
            tipTextLabel.textColor = UIColor.blackColor()
            totalTextLabel.textColor = UIColor.blackColor()
            billField.textColor = UIColor.blackColor()
            billField.backgroundColor = UIColor.whiteColor()
            tipLabel.textColor = UIColor.blackColor()
            totalLabel.textColor = UIColor.blackColor()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var currencyFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {

        if billField.center.y == 200.0 && billField.text != "" {
            UIView.animateWithDuration(0.5, delay: 0.0,
                options: .CurveEaseInOut, animations:{
                    self.billField.center.y -= 87
                    self.tipControl.center.y -= 170
                    self.tipLabel.center.y -= 170
                    self.tipTextLabel.center.y -= 170
            }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0.3,
                options: .CurveEaseInOut, animations:{
                    self.totalLabel.center.y -= 170
                    self.onePerson.center.y -= 170
                }, completion: nil)
            
        }else if billField.center.y != 200.0 && billField.text == ""{
            UIView.animateWithDuration(0.5, delay: 0.0,
                options: .CurveEaseInOut, animations:{
                    self.billField.center.y += 87
                    self.tipControl.center.y += 170
                    self.tipLabel.center.y += 170
                    self.tipTextLabel.center.y += 170
                    self.totalLabel.center.y += 170
                    self.onePerson.center.y += 170
                }, completion: nil)
        }
        
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        //tipLabel.text = String(format: "$%.2f",tip)
        //totalLabel.text = String(format: "$%.2f", total)
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

