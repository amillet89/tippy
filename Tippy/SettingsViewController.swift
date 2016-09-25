//
//  SettingsViewController.swift
//  Tippy
//
//  Created by Alex Millet on 9/20/16.
//  Copyright © 2016 Alex Millet. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var tipControlLabel: UILabel!
    
     let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setDefault(_ sender: AnyObject) {
        let tipIndex = tipControl.selectedSegmentIndex
        
        defaults.set(tipIndex, forKey: "tipIndex")
        defaults.synchronize()
    }
    
    @IBAction func themeSwitch(_ sender: AnyObject) {
        let isLightTheme = themeSwitch.isOn
        
        defaults.set(isLightTheme, forKey: "isLightTheme")
        defaults.synchronize()
        setTheme()
    }
    
    func setTheme () {
        var backgroundColor = UInt(0x59134E)
        var mainColor = UInt(0xE866E8)
        let isLightTheme = defaults.bool(forKey: "isLightTheme")
        
        if (isLightTheme) {
            backgroundColor = UInt(0xFCF9FD)
            mainColor = UInt(0x5F64E5)
        }
        
        settingsView.backgroundColor = UIColorFromRGB(rgbValue: backgroundColor)
        tipControl.tintColor = UIColorFromRGB(rgbValue: mainColor)
        themeSwitch.onTintColor = UIColorFromRGB(rgbValue: mainColor)
        themeLabel.textColor = UIColorFromRGB(rgbValue: mainColor)
        tipControlLabel.textColor = UIColorFromRGB(rgbValue: mainColor)
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
        let isLightTheme = defaults.bool(forKey: "isLightTheme")
        themeSwitch.isOn = isLightTheme
        setTheme()
        
        let tipIndex = defaults.integer(forKey: "tipIndex")
        
        tipControl.selectedSegmentIndex = tipIndex
        
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
