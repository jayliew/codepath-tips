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
class ViewController: UIViewController, UITextFieldDelegate {

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
 
    @IBOutlet weak var billAmountLabel: UILabel!

    let pink = UIColor(red:0xF8, green: 0xDB, blue: 0xDA)
    let lightPink = UIColor(red:0xF6, green: 0xCA, blue: 0xC8)
    let blue = UIColor(red:0x91, green:0xA4, blue:0xD0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        totalForTwoLabel.text = "$0.00"
        totalForThreeLabel.text = "$0.00"
        billField.becomeFirstResponder()
        billField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "default_tip_index")
        
        // Set theme color
        if defaults.bool(forKey: "dark_theme") == true {
            
            self.view.backgroundColor = UIColor(red:0x91, green:0xA4, blue:0xD0)
            billField.backgroundColor = blue
            billField.textColor = UIColor.black
            billField.backgroundColor = pink
            
            tipControl.tintColor = pink
            tipControl.backgroundColor = blue
            tipControl.layer.cornerRadius = 3
            tipControl.layer.shadowColor = UIColor.black.cgColor
            tipControl.layer.shadowOffset = CGSize(width: 3, height: 3)
            tipControl.layer.shadowOpacity = 0.3
            tipControl.layer.shadowRadius = 3.0
            
            tipTextLabel.textColor = UIColor.black
            tipLabel.textColor = UIColor.black
            totalLabel.textColor = UIColor.black
            totalForTwoLabel.textColor = UIColor.black
            totalForThreeLabel.textColor = UIColor.black
            
        }else{
            self.view.backgroundColor = pink
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
            totalLabel.textColor = UIColor.black
            totalForTwoLabel.textColor = UIColor.black
            totalForThreeLabel.textColor = UIColor.black
        }
        
        if defaults.object(forKey: "billAmount") != nil {
            // grab value from NSUserDefaults if it exists
            billField.text = String(defaults.double(forKey: "billAmount"))
            onEditingChanged(billField)
        }
    }

    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        // This provides input sanitization to prevent an invalid Float from being entered
        let oldText = textField.text ?? ""
        let newText = oldText + string
        
        
        if oldText.range(of: ".") != nil && string.range(of: ".") != nil {
            return false
        }
        
        if let _ = Float(newText){
            return true
        }else{
            return false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let localeString = String(describing: Locale.current)
        
        let charOne = localeString[localeString.startIndex]
        let charTwo = localeString[localeString.index(after: localeString.startIndex)]
        
        let newLocale: String?
        if(charOne == "e" && charTwo == "n"){
            newLocale = "en_US"
        }else{
            // e.g. gb_gb or de_de
            newLocale = String(charOne) + String(charTwo) + "_" + String(charOne) + String(charTwo)
        }
        formatter.locale = Locale(identifier: newLocale!)
        
//        print(">>>" + String(describing: formatter.locale) + "<<<")
        
        return formatter
    }
    
    @IBAction func backFromSettings(_ sender: UIStoryboardSegue){
    }
    
    @IBAction func onEditingChanged(_ sender: AnyObject) {
        let billAmount = NSString(string: billField.text!).doubleValue
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = currencyFormatter.string(from: NSNumber(value: tip))
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: total))
        totalForTwoLabel.text = currencyFormatter.string(from: NSNumber(value: (total / 2)))
        totalForThreeLabel.text = currencyFormatter.string(from: NSNumber(value: (total / 3)))
        
        totalForTwoLabel.alpha = 0
        totalForThreeLabel.alpha = 0
        
        twoPersonA.alpha = 0
        twoPersonB.alpha = 0

        threePersonA.alpha = 0
        threePersonB.alpha = 0
        threePersonC.alpha = 0

        UIView.animate(withDuration:0.5, animations: {
            self.totalForTwoLabel.alpha = 1
            self.twoPersonA.alpha = 1
            self.twoPersonB.alpha = 1
        })
        UIView.animate(withDuration:1.0, animations: {
            self.totalForThreeLabel.alpha = 1
            self.threePersonA.alpha = 1
            self.threePersonB.alpha = 1
            self.threePersonC.alpha = 1
        })
        
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

