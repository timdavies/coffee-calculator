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
    @IBOutlet weak var coffeeIncrementButton: UIButton!
    @IBOutlet weak var waterIncrementButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Iterate over input and output controls and apply some common
        // styles (rounded edges, border colour, etc):
        for control in [
            coffeeInput, waterInput,
            coffeeDecrementButton, coffeeIncrementButton,
            waterIncrementButton, waterDecrementButton
        ] {
            control.layer.cornerRadius = 4.0
            control.layer.masksToBounds = true
            control.layer.borderColor = UIColor.grayColor().CGColor
            control.layer.borderWidth = 1.0
        }
        
        // Disable input on coffee input and water input fields
        // as we don't want the keyboard opened:
        coffeeInput.enabled = false
        waterInput.enabled = false
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
}
