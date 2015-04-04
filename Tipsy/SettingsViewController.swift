//
//  SettingsViewController.swift
//  Tipsy
//
//  Created by Baris Taze on 4/3/15.
//  Copyright (c) 2015 Baris Taze. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tipSegmentController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // get defaults
        let defaults = NSUserDefaults.standardUserDefaults();
        let defaultTipPercentageIndex = defaults.integerForKey("default_tip_percentage")
        tipSegmentController.selectedSegmentIndex = defaultTipPercentageIndex;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectionChanged(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults();
        let defaultTipPercentageIndex = tipSegmentController.selectedSegmentIndex;
        defaults.setInteger(defaultTipPercentageIndex, forKey:"default_tip_percentage");
        defaults.synchronize();
    }
}
