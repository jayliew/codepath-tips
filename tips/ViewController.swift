//
//  ViewController.swift
//  tips
//
//  Created by Jay Liew on 1/6/16.
//  Copyright © 2016 Jay Liew. All rights reserved.
//

import UIKit

extension UIColor {
    // Extend UIColor to allow HTML-style hex values
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Bad red hex value: 0 - 255 only")
        assert(green >= 0 && green <= 255, "Bad green hex value: 0 - 255 only")
        assert(blue >= 0 && blue <= 255, "Bad blue hex value: 0 - 255 only")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipTextLabel: UILabel!
    @IBOutlet weak var onePerson: UIImageView!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var totalForTwoLabel: UILabel!
    @IBOutlet weak var totalForThreeLabel: UILabel!
    @IBOutlet weak var twoPersonA: UIImageView!
    @IBOutlet weak var twoPersonB: UIImageView!
    @IBOutlet weak var threePersonA: UIImageView!
    @IBOutlet weak var threePersonB: UIImageView!
    @IBOutlet weak var threePersonC: UIImageView!
    
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
        
        // Set theme color
        if defaults.boolForKey("dark_theme") == true {
            self.view.backgroundColor = UIColor(red: 0.0235, green: 0, blue: 0.3765, alpha: 1.0)
            billField.backgroundColor = UIColor(red: 0.0235, green: 0, blue: 0.3765, alpha: 1.0)
            tipTextLabel.textColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            billField.textColor = UIColor.whiteColor()
            billField.backgroundColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            tipLabel.textColor = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            totalLabel.textColor = UIColor.whiteColor()
            totalForTwoLabel.textColor = UIColor.whiteColor()
            totalForThreeLabel.textColor = UIColor.whiteColor()
        }else{
            self.view.backgroundColor = UIColor(red:0xCC, green: 0xE5, blue: 0xFF)
            billField.backgroundColor = UIColor.whiteColor()
            tipTextLabel.textColor = UIColor.blackColor()
            billField.textColor = UIColor.blackColor()
            billField.backgroundColor = UIColor.whiteColor()
            tipLabel.textColor = UIColor.blackColor()
            totalLabel.textColor = UIColor.blackColor()
            totalForTwoLabel.textColor = UIColor.blackColor()
            totalForThreeLabel.textColor = UIColor.blackColor()
        }
        
        if defaults.objectForKey("billAmount") != nil {
            // grab value from NSUserDefaults if it exists
            billField.text = String(defaults.doubleForKey("billAmount"))
            onEditingChanged(billField)
        }

    }

    private func hideBillSplits(){
        // hide all views related to splitting the bill 2 and 3 ways
        UIView.animateWithDuration(0.5, delay: 0.0,
                                   options: .CurveEaseInOut, animations:{
                                    
                                    self.totalForTwoLabel.center.y += 200
                                    self.twoPersonA.center.y += 182
                                    self.twoPersonB.center.y += 182
                                    
                                    self.totalForThreeLabel.center.y += 120
                                    self.threePersonA.center.y += 102
                                    self.threePersonB.center.y += 102
                                    self.threePersonC.center.y += 102
                                    
            }, completion: nil)
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

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            // If landscape
            self.billField.center.y = 80
        } else {
            // If portrait
            if billField.text == "" {
                billField.center.y = 200
            }
            else{
                onEditingChanged(billField)
                //billField.center.y = 200 - 87
            }
            
        }
    }
    
    @IBAction func backFromSettings(sender: UIStoryboardSegue){
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {

        print("on editing changed")
        
        if billField.center.y == 200.0 && billField.text != "" {
            // If bill amount field is not empty, move these
            // views up the y axis
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

            UIView.animateWithDuration(0.5, delay: 0.6,
                options: .CurveEaseInOut, animations:{
                    self.totalForTwoLabel.center.y -= 200
                    self.twoPersonA.center.y -= 182
                    self.twoPersonB.center.y -= 182
                }, completion: nil)

            UIView.animateWithDuration(0.5, delay: 0.9,
                options: .CurveEaseInOut, animations:{
                    self.totalForThreeLabel.center.y -= 120
                    self.threePersonA.center.y -= 102
                    self.threePersonB.center.y -= 102
                    self.threePersonC.center.y -= 102
                }, completion: nil)
        }
        
        else if billField.center.y != 200.0 && billField.text == "" && UIDevice.currentDevice().orientation.isPortrait.boolValue{
            // If bill amount field is empty, move these
            // views down the y axis

            UIView.animateWithDuration(0.5, delay: 0.0,
                options: .CurveEaseInOut, animations:{
                    self.billField.center.y += 87
                    self.tipControl.center.y += 170
                    self.tipLabel.center.y += 170
                    self.tipTextLabel.center.y += 170
                    self.totalLabel.center.y += 170
                    self.onePerson.center.y += 170
                }, completion: nil)

            hideBillSplits()
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
        totalForTwoLabel.text = currencyFormatter.stringFromNumber(total / 2)
        totalForThreeLabel.text = currencyFormatter.stringFromNumber(total / 3)
        
    }
    
    override func viewWillDisappear(animated: Bool){
        super.viewWillDisappear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(NSString(string: billField.text!).doubleValue, forKey: "billAmount")
    }
    

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

