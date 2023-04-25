//
//  HomeViewController.swift
//  VehiclesTask
//
//  Created by Aleksandra Lazarevic on 24.4.23..
//

import UIKit

class VehicleCell: UITableViewCell {
    
    @IBOutlet weak var lblVin: UILabel!
    @IBOutlet weak var lblMake: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    
    
    @IBOutlet weak var stackVin: UIStackView!
    @IBOutlet weak var stackMake: UIStackView!
    @IBOutlet weak var stackModel: UIStackView!
}

class HomeViewController: UIViewController {

    @IBOutlet weak var headerview: UIView!
    
    var vehicles = [Vehicle]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerview.layer.masksToBounds = false
        headerview.layer.shadowRadius = 2
        headerview.layer.shadowOpacity = 1
        headerview.layer.shadowColor = UIColor.gray.cgColor
        headerview.layer.shadowOffset = CGSize(width: 0 , height:2)
        headerview.layer.zPosition = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchVehicles()
    }
    
    func fetchVehicles() {
        Requests.getVehicles { _, res in
            self.vehicles = res
            self.tableView.reloadData()
        }
    }
    
    @IBAction func unwindToHome (_ unwindSegue: UIStoryboardSegue) {
        
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "vehicleCell") as? VehicleCell {
            
            cell.stackVin.isHidden = false
            cell.stackMake.isHidden = false
            cell.stackModel.isHidden = false
            
            let rowData = vehicles[indexPath.row]
            if rowData.vin != "" {
                cell.lblVin.text = rowData.vin
            } else {
                cell.stackVin.isHidden = true
            }
            if rowData.make != "" {
                cell.lblMake.text = rowData.make
            } else {
                cell.stackMake.isHidden = true
            }
            if rowData.model != "" {
                cell.lblModel.text = rowData.model
            } else {
                cell.stackModel.isHidden = true
            }

            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
