//
//  AddNewViewController.swift
//  VehiclesTask
//
//  Created by Aleksandra Lazarevic on 24.4.23..
//

import UIKit

class AddNewViewController: UIViewController {

    @IBOutlet weak var tfVinValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func validate() -> Bool {
        if self.tfVinValue.text?.trimmingCharacters(in: .whitespaces) != ""{
            return true
        }
        return false
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        if validate() {
            Requests.sendVehicle(vin: tfVinValue.text!) { res, details in
                print(details)
            }
        }
    }
    
}
