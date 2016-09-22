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

    // MARK: Outlets
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipTextLabel: UILabel!
    @IBOutlet weak var onePerson: UIImageView!
    
    @IBOutlet weak var twoPersonA: UIImageView!
    @IBOutlet weak var twoPersonB: UIImageView!
    @IBOutlet weak var totalForTwoLabel: UILabel!
    
    @IBOutlet weak var threePersonA: UIImageView!
    @IBOutlet weak var threePersonB: UIImageView!
    @IBOutlet weak var threePersonC: UIImageView!
    @IBOutlet weak var totalForThreeLabel: UILabel!
 
//    @IBOutlet weak var totalForTwoLabel: UILabel!
//    @IBOutlet weak var totalForThreeLabel: UILabel!
//    @IBOutlet weak var twoPersonA: UIImageView!
//    @IBOutlet weak var twoPersonB: UIImageView!
//    @IBOutlet weak var threePersonA: UIImageView!
//    @IBOutlet weak var threePersonB: UIImageView!
//    @IBOutlet weak var threePersonC: UIImageView!

    @IBOutlet weak var billAmountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        twoPersonA.contentMode = .ScaleAspectFill
//        twoPersonB.contentMode = .ScaleAspectFill
//        threePersonA.contentMode = .ScaleAspectFill
//        threePersonB.contentMode = .ScaleAspectFill
//        threePersonC.contentMode = .ScaleAspectFill

//        twoPersonA.contentMode = .ScaleAspectFit
//        twoPersonB.contentMode = .ScaleAspectFit
//        threePersonA.contentMode = .ScaleAspectFit
//        threePersonB.contentMode = .ScaleAspectFit
//        threePersonC.contentMode = .ScaleAspectFit

        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        totalForTwoLabel.text = "$0.00"
        totalForThreeLabel.text = "$0.00"
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "default_tip_index")
        
        // Set theme color
        if defaults.bool(forKey: "dark_theme") == true {
            
            let darkBlue = UIColor(red: 0.0235, green: 0, blue: 0.3765, alpha: 1.0)
            let lightBlue = UIColor(red: 0, green: 0.5647, blue: 1, alpha: 1.0)
            self.view.backgroundColor = darkBlue
            billField.backgroundColor = darkBlue
            tipTextLabel.textColor = lightBlue
            billField.textColor = UIColor.white
            billField.backgroundColor = lightBlue
            tipLabel.textColor = lightBlue
            totalLabel.textColor = UIColor.white
//            totalForTwoLabel.textColor = UIColor.whiteColor()
//            totalForThreeLabel.textColor = UIColor.whiteColor()
        }else{
            self.view.backgroundColor = UIColor(red:0xF8, green: 0xDB, blue: 0xDA)
            //self.view.backgroundColor = UIColor(red:0xF6, green: 0xCA, blue: 0xC8)
            tipControl.tintColor = UIColor(red:0x91, green:0xA4, blue:0xD0)
            
            tipControl.backgroundColor = UIColor.white
            tipControl.layer.cornerRadius = 3
            tipControl.layer.shadowColor = UIColor.black.cgColor
            tipControl.layer.shadowOffset = CGSize(width: 3, height: 3)
            tipControl.layer.shadowOpacity = 0.3
            tipControl.layer.shadowRadius = 3.0

            
            billField.backgroundColor = UIColor.white
            tipTextLabel.textColor = UIColor.black
            billField.textColor = UIColor.black
            billField.backgroundColor = UIColor.white
            tipLabel.textColor = UIColor.black
//            totalLabel.textColor = UIColor.blackColor()
//            totalForTwoLabel.textColor = UIColor.blackColor()
//            totalForThreeLabel.textColor = UIColor.blackColor()
        }
        
        if defaults.object(forKey: "billAmount") != nil {
            // grab value from NSUserDefaults if it exists
            billField.text = String(defaults.double(forKey: "billAmount"))
            onEditingChanged(billField)
        }
    }

    fileprivate func hideBillSplits(){
        // hide all views related to splitting the bill 2 and 3 ways
        UIView.animate(withDuration: 0.5, delay: 0.0,
                                   options: UIViewAnimationOptions(), animations:{
//                                    self.totalForTwoLabel.center.y += 200
//                                    self.twoPersonA.center.y += 182
//                                    self.twoPersonB.center.y += 182
//                                    
//                                    self.totalForThreeLabel.center.y += 120
//                                    self.threePersonA.center.y += 102
//                                    self.threePersonB.center.y += 102
//                                    self.threePersonC.center.y += 102
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
//            // If landscape
//            self.billField.center.y = 80
//        } else {
//            // If portrait
//            if billField.text == "" {
//                billField.center.y = 200
//            }
//            else{
//                onEditingChanged(billField)
//            }
//        }
    }
    
    @IBAction func backFromSettings(_ sender: UIStoryboardSegue){
    }
    
    @IBAction func onEditingChanged(_ sender: AnyObject) {        
        if billField.center.y == 200.0 && billField.text != "" {
            // If bill amount field is not empty, move these
            // views up the y axis
            UIView.animate(withDuration: 0.5, delay: 0.0,
                options: UIViewAnimationOptions(), animations:{
//                    self.billField.center.y -= 87
//                    self.tipControl.center.y -= 170
//                    self.tipLabel.center.y -= 170
//                    self.tipTextLabel.center.y -= 170
            }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0.3,
                options: UIViewAnimationOptions(), animations:{
//                    self.totalLabel.center.y -= 170
//                    self.onePerson.center.y -= 170
                }, completion: nil)

            UIView.animate(withDuration: 0.5, delay: 0.6,
                options: UIViewAnimationOptions(), animations:{
//                    self.totalForTwoLabel.center.y -= 200
//                    self.twoPersonA.center.y -= 182
//                    self.twoPersonB.center.y -= 182
                }, completion: nil)

            UIView.animate(withDuration: 0.5, delay: 0.9,
                options: UIViewAnimationOptions(), animations:{
//                    self.totalForThreeLabel.center.y -= 120
//                    self.threePersonA.center.y -= 102
//                    self.threePersonB.center.y -= 102
//                    self.threePersonC.center.y -= 102
                }, completion: nil)
        }
        
        else if billField.center.y != 200.0 && billField.text == "" && UIDevice.current.orientation.isPortrait{
            // If bill amount field is empty, move these
            // views down the y axis

            UIView.animate(withDuration: 0.5, delay: 0.0,
                options: UIViewAnimationOptions(), animations:{
//                    self.billField.center.y += 87
//                    self.tipControl.center.y += 170
//                    self.tipLabel.center.y += 170
//                    self.tipTextLabel.center.y += 170
//                    self.totalLabel.center.y += 170
//                    self.onePerson.center.y += 170
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
        
        
        tipLabel.text = currencyFormatter.string(from: NSNumber(value: tip))
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: total))
        totalForTwoLabel.text = currencyFormatter.string(from: NSNumber(value: (total / 2)))
        totalForThreeLabel.text = currencyFormatter.string(from: NSNumber(value: (total / 3)))
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        let defaults = UserDefaults.standard
        defaults.set(NSString(string: billField.text!).doubleValue, forKey: "billAmount")
    }
    

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
}

