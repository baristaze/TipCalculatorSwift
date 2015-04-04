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
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        var tipPercentages = [0.18, 0.20, 0.22];
        var tipPercentage = tipPercentages[tipSegmentController.selectedSegmentIndex]
        var billAmount = (billField.text as NSString).doubleValue
        var tipAmount = billAmount * tipPercentage
        var totalAmount = billAmount + tipAmount
        tipLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", totalAmount)
        
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onSettings(sender: AnyObject) {
        
    }
}

