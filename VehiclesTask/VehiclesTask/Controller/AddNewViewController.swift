//
//  AddNewViewController.swift
//  VehiclesTask
//
//  Created by Aleksandra Lazarevic on 24.4.23..
//

import UIKit

class AddNewViewController: UIViewController {

    @IBOutlet weak var tfVinValue: UITextField!
    @IBOutlet weak var tfMake: UITextField!
    @IBOutlet weak var tfModel: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func validate() -> Bool {
        if self.tfVinValue.text?.trimmingCharacters(in: .whitespaces) != "" && self.tfMake.text?.trimmingCharacters(in: .whitespaces) != "" && self.tfModel.text?.trimmingCharacters(in: .whitespaces) != ""{
            return true
        }
        return false
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        if validate() {
            self.activityIndicator.startAnimating()
            Requests.sendVehicle(vin: tfVinValue.text!, make: tfMake.text!, model: tfModel.text!) { res, details in

                if details["id"] as? String != nil {
                    
                    SetupData.showAlert(title: "Success", message: "Vehicle\n \(details["vin"] as? String ?? "") has been created!", viewController: self)
                    self.tfVinValue.text = ""
                    self.tfMake.text = ""
                    self.tfModel.text = ""
                    
                } else {
                    SetupData.showAlert(title: "Error", message: details["description"] as? String ?? "", viewController: self)
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                
            }
        }
    }
    
}
