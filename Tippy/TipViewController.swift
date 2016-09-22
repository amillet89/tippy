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
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipBar: UIView!
    @IBOutlet weak var tipActiveBar: UIView!
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
    
    @IBAction func startBillEdit(_ sender: AnyObject) {
        changeBarColor(firstColor: 1, secondColor: 0)
    }
    
    @IBAction func endBillEdit(_ sender: AnyObject) {
        changeBarColor(firstColor: 1, secondColor: 1)
    }
    
    func changeBarColor(firstColor: Int, secondColor: Int) {
        UIView.animate(withDuration: 0.4, animations: {
            self.tipBar.alpha = CGFloat(firstColor)
            self.tipActiveBar.alpha = CGFloat(secondColor)
        })
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
        
        tipLabel.text = formatTip(value: tip) //String(format: "$%.2f", tip)
        totalLabel.text = formatTip(value: total) //String(format: "$%.2f",total)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

