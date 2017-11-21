//
//  SignUpViewController.swift
//  TestMultipleStoryboards
//
//  Created by Liu, Robert J on 10/28/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var confirmTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var alertController: UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"

        // Do any additional setup after loading the view.
        
        // UISetup
        confirmButton.layer.cornerRadius = 10
        confirmButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 10
        cancelButton.clipsToBounds = true
        
        // Set delegates
        nameTxtField.delegate = self
        passTxtField.delegate = self
        confirmTxtField.delegate = self
        emailTxtField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = Style.backgroundColor
        self.navigationController?.navigationBar.barTintColor = Style.barTintColor
        self.navigationController?.navigationBar.tintColor = Style.textColor
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : Style.textColor]
        
        confirmButton.setTitleColor(Style.buttonTextColor, for: .normal)
        confirmButton.backgroundColor = Style.buttonBackgroundColor
        cancelButton.setTitleColor(Style.buttonTextColor, for: .normal)
        cancelButton.backgroundColor = Style.buttonBackgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Actually signs up based on text fields
    @IBAction func signUpBtn(_ sender: Any) {
        let name = nameTxtField!.text!
        let pass = passTxtField!.text!
        let confirm = confirmTxtField!.text!
        let email = emailTxtField!.text!
        if name != "" && pass != "" && confirm != "" && email != ""{
            if pass == confirm {
                if pass.count < 6 {
                    self.errorMessage(title: "Password Too Short", message: "Password must be at least 6 characters")
                }
                else {
                    Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                        if (user != nil) {
                            self.dismiss(animated: true, completion: nil)
                        }
                        else {
                            self.errorMessage(title: "Invalid Email", message: "Email not valid or is already used")
                        }
                    }
                }
            }
            else {
                self.errorMessage(title: "Password Mismatch", message: "Please enter matching passwords")
            }
        }
        else {
            self.errorMessage(title: "Empty Fields", message: "Must fill out all fields")
        }
    }

    // Displays error messages with a given title and description message, has default cancel button
    func errorMessage(title: String, message: String) {
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        self.alertController!.addAction(cancelAction)
        self.present(self.alertController!, animated: true, completion: nil)
    }
    
    // returns to previous view
    @IBAction func returnBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
