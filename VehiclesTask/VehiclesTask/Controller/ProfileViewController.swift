//
//  ProfileViewController.swift
//  VehiclesTask
//
//  Created by Aleksandra Lazarevic on 24.4.23..
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblLastLogin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      fillData()
    }
    
    func fillData() {
        self.lblName.text = User.name
        self.lblEmail.text = User.email
        self.lblLastLogin.text = SetupData.formatDate(str: User.lastTimeOnline)
    }
    

    @IBAction func btnLogoutTapped(_ sender: Any) {
        let alert = UIAlertController(title: "You are leaving the user zone", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Log out", style: .destructive) { _ in
            self.performSegue(withIdentifier: "logout", sender: self)
        }
        let action2 = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true)
    }

}
