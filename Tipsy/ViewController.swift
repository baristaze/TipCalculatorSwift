//
//  ViewController.swift
//  Tipsy
//
//  Created by Baris Taze on 4/3/15.
//  Copyright (c) 2015 Baris Taze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSegmentController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // clear fields
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.becomeFirstResponder()
        
        // get defaults
        let defaults = NSUserDefaults.standardUserDefaults();
        let defaultTipPercentageIndex = defaults.integerForKey("default_tip_percentage")
        tipSegmentController.selectedSegmentIndex = defaultTipPercentageIndex;
        
        // get last session info
        let lastBillTime = defaults.stringForKey("last_bill_time");
        if(lastBillTime != nil){
            
            let dateText : String = lastBillTime!;
            let dateFormatter = NSDateFormatter();
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSSxxx";
            let date = dateFormatter.dateFromString(dateText);
            let diff = NSDate().timeIntervalSinceDate(date!);
            if(diff <= 600000.0){
                
                let lastBillAmount = defaults.doubleForKey("last_bill_amount");
                billField.text = String(format: "%.2f", lastBillAmount);
        
                let tipIndex = defaults.integerForKey("last_tip_index");
                tipSegmentController.selectedSegmentIndex = tipIndex;
                
                // update the UI
                updateTipUI();
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateTipUI();
        saveToFile();
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func updateTipUI(){
        var tipPercentages = [0.18, 0.20, 0.22];
        var tipPercentage = tipPercentages[tipSegmentController.selectedSegmentIndex]
        var billAmount = (billField.text as NSString).doubleValue
        var tipAmount = billAmount * tipPercentage
        var totalAmount = billAmount + tipAmount
        tipLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", totalAmount);
    }
    
    func saveToFile(){
        
        var billAmount = (billField.text as NSString).doubleValue;
        if(billAmount > 0){
            
            let defaults = NSUserDefaults.standardUserDefaults();
            defaults.setDouble(billAmount, forKey: "last_bill_amount");
            defaults.setInteger(tipSegmentController.selectedSegmentIndex, forKey: "last_tip_index");
            
            let dateFormatter = NSDateFormatter();
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSSxxx";
            let now = dateFormatter.stringFromDate(NSDate());
            defaults.setObject(now, forKey: "last_bill_time");
        }
    }
}

