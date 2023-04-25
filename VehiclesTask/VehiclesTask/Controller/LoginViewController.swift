//
//  LoginViewController.swift
//  VehiclesTask
//
//  Created by Aleksandra Lazarevic on 21.4.23..
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var vwLoginControls: UIView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnEyeSecure: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var secureTextPassword = true
    var showAlert = false
    var goToHome = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customizeUI()
    }
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        if validateFields() {
            activityIndicator.startAnimating()
            Requests.loginUser(email: tfEmail.text!, password: tfPassword.text! ) { success, data in
                if success {
                    print("Dobrodosao! \(data["token"] as? String ?? "")")
                    User.token = data["token"] as? String ?? ""
                    if let user = data["user"] as? [String: Any] {
                        User.email = user["email"] as? String ?? ""
                        User.name = user["name"] as? String ?? ""
                        User.userId = user["id"] as? String ?? ""
                        User.lastTimeOnline = user["lastTimeOnline"] as? String ?? ""
                        print("ID USERA \(User.userId)")
                        DispatchQueue.main.async {
                            self.tfEmail.text = ""
                            self.tfPassword.text = ""
                            self.activityIndicator.stopAnimating()
                            self.performSegue(withIdentifier: "home", sender: self)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        SetupData.showAlert(title: "Error", message: data["description"] as? String ?? "", viewController: self)
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    

    func validateFields() -> Bool {
        if self.tfEmail.text?.trimmingCharacters(in: .whitespaces) != "" &&  self.tfPassword.text?.trimmingCharacters(in: .whitespaces) != "" {
            return true
        }
        return false
    }
    
    func changePassFieldAndEye () {
        secureTextPassword = !secureTextPassword
        tfPassword.isSecureTextEntry = secureTextPassword
        btnEyeSecure.setImage(UIImage(systemName: secureTextPassword ? "eye.slash" : "eye"), for: .normal)
    }

    @IBAction func btnEyeTapped(_ sender: Any) {
        changePassFieldAndEye()
    }
    func customizeUI() {
        self.tfPassword.isSecureTextEntry = secureTextPassword
        self.btnEyeSecure.setImage(UIImage(systemName: secureTextPassword ? "eye.slash" : "eye"), for: .normal)
        self.btnLogin.layer.cornerRadius = 10
        self.vwLoginControls.layer.borderColor = UIColor.red.cgColor
        self.vwLoginControls.layer.borderWidth = 0.5
        self.vwLoginControls.layer.cornerRadius = 10
    }
    @IBAction func unwindToLogin (_ unwindSegue: UIStoryboardSegue) {
        
    }
}

