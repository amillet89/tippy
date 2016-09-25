//
//  ViewController.swift
//  Tippy
//
//  Created by Alex Millet on 9/20/16.
//  Copyright © 2016 Alex Millet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipField: UILabel!
    @IBOutlet weak var totalField: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipBar: UIView!
    @IBOutlet weak var totalsBar: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onBillChange(_ sender: AnyObject) {
        calculateTip()
    }
    
    func formatTip(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: value))!
    }
    
    func calculateTip() {
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipField.text = formatTip(value: tip)
        totalField.text = formatTip(value: total)
    }
    
    func setTheme() {
        var backgroundColor = UInt(0x59134E)
        var mainColor = UInt(0xE866E8)
        let isLightTheme = defaults.bool(forKey: "isLightTheme")
        
        if (isLightTheme) {
            backgroundColor = UInt(0xFCF9FD)
            mainColor = UInt(0x5F64E5)
        }
        
        billField.textColor = UIColorFromRGB(rgbValue: backgroundColor)
        tipField.textColor = UIColorFromRGB(rgbValue: mainColor)
        tipLabel.textColor = UIColorFromRGB(rgbValue: mainColor)
        totalField.textColor = UIColorFromRGB(rgbValue: mainColor)
        totalLabel.textColor = UIColorFromRGB(rgbValue: mainColor)
        tipControl.tintColor = UIColorFromRGB(rgbValue: mainColor)
        tipBar.backgroundColor = UIColorFromRGB(rgbValue: mainColor)
        totalsBar.backgroundColor = UIColorFromRGB(rgbValue: backgroundColor)
        
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTheme()
        billField.becomeFirstResponder()
        let tipIndex = defaults.integer(forKey: "tipIndex")
        tipControl.selectedSegmentIndex = tipIndex
        
        if let storedBill = defaults.string(forKey: "storedBill") {
            billField.text = storedBill
        }
        
        calculateTip()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        defaults.set(billField.text!, forKey: "storedBill")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
}

