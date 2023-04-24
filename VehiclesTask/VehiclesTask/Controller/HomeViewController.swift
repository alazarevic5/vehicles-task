//
//  HomeViewController.swift
//  VehiclesTask
//
//  Created by Aleksandra Lazarevic on 24.4.23..
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var headerview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerview.layer.masksToBounds = false
        headerview.layer.shadowRadius = 2
        headerview.layer.shadowOpacity = 1
        headerview.layer.shadowColor = UIColor.gray.cgColor
        headerview.layer.shadowOffset = CGSize(width: 0 , height:2)
        headerview.layer.zPosition = 1
        fetchVehicles()
    }
    
    @IBAction func unwindToHome (_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    func fetchVehicles() {
        Requests.getVehicles { _, _ in
                
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
