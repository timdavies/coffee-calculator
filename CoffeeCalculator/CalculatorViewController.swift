//
//  CalculatorViewController.swift
//  CoffeeCalculator
//
//  Created by Tim Davies on 15/12/2014.
//  Copyright (c) 2014 Tim Davies. All rights reserved.
//

import UIKit
import QuartzCore

class CalculatorViewController: UIViewController {
    var coffee:Int = 21
    var water:Int = 300
    
    @IBOutlet weak var coffeeInput: UITextField!
    @IBOutlet weak var waterInput: UITextField!
    @IBOutlet weak var coffeeDecrementButton: UIButton!
    @IBOutlet weak var waterDecrementButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for field in [coffeeInput, waterInput] {
            let field = field as UITextField
            field.layer.cornerRadius = 4.0
            field.layer.masksToBounds = true
            field.layer.borderColor = UIColor.grayColor().CGColor
            field.layer.borderWidth = 1.0
            field.enabled = false
        }
        
    }
    
    
    @IBAction func incrementCoffee(sender: AnyObject) {
        coffee += 1
        water = Int((Float(coffee) / 7.0) * 100)
        renderInputs()
    }
    
    @IBAction func decrementCoffee(sender: AnyObject) {
        coffee -= 1
        water = Int((Float(coffee) / 7.0) * 100)
        renderInputs()
    }
    
    @IBAction func incrementWater(sender: AnyObject) {
        if (water % 25 != 0) {
            water += 25 - (water % 25)
        } else {
            water += 25
        }
        
        coffee = Int((Float(water) / 100) * 7 + 0.5)
        
        renderInputs()
    }
    
    @IBAction func decrementWater(sender: AnyObject) {
        if (water % 25 != 0) {
            water -= water % 25
        } else {
            water -= 25
        }
        
        coffee = Int((Float(water) / 100) * 7 + 0.5)
        
        renderInputs()
    }
    
    func renderInputs() {
        coffeeInput.text = "\(coffee)g"
        waterInput.text = "\(water)ml"
        
        if (coffee - 1 <= 0) {
            coffeeDecrementButton.enabled = false
        } else {
            coffeeDecrementButton.enabled = true
        }
        
        if (water - 25 <= 0) {
            waterDecrementButton.enabled = false
        } else {
            waterDecrementButton.enabled = true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
