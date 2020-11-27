//
//  ViewController.swift
//  SaveAppleHealthDataExample
//
//  Created by Domo on 03/12/2019.
//  Copyright © 2019 Domo. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldValue: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        HealthKitSetupAssistant.authorizeHealthKit { (result, error) in
            if result {
                print("Auth ok")
            } else {
                print("Auth denied")
            }
        }
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let value = textFieldValue.text else {
            return
        }
        
        HealthKitSetupAssistant.saveSteps(stepsCountValue: Int(value)!, date: datePicker.date) { (error) in
            print(error)
        }
        
    }
    
}
