//
//  MainViewController.swift
//  TestMultipleStoryboards
//
//  Created by Robert on 10/8/17.
//  Copyright © 2017 cs329. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class MainViewController: UIViewController, UITextFieldDelegate {
    
    var alertController: UIAlertController? = nil
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial setup
        DataStore.shared.loadEvents()
        
        nameTxtField.delegate = self
        passTxtField.delegate = self
        
        loginBtn.layer.cornerRadius = 10
        loginBtn.clipsToBounds = true
        signUpButton.layer.cornerRadius = 10
        signUpButton.clipsToBounds = true
        resetButton.layer.cornerRadius = 10
        resetButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnShowSignUp(_ sender: Any) {
    
        // Manually instantiate the detail view controller that lives in the Joe storyboard and present it.
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpViewController

        let nc = UINavigationController(rootViewController: vc)
        // Show it to the user.
        present(nc, animated: true, completion: nil)
    }
    
    @IBAction func onSubmitBtn(_ sender: Any) {
        // Ensure information filled out
        if nameTxtField!.text! != "" && passTxtField!.text! != "" {
            Auth.auth().signIn(withEmail: nameTxtField!.text!, password: passTxtField!.text!) { (user, error) in
                if user != nil {
                    if let user = user {
                        let uid = user.uid
                        let email = user.email
                        
                        let user = User(id: uid, email: email!)
                        DataStore.shared.setUser(user: user)
                    }
                    self.performSegue(withIdentifier: "loginSegue", sender: AnyObject?.self)
                }
                else {
                    print(error!)
                    self.errorMessage(title: "Invalid Login", message: "Username or password is not valid")
                }
            }
        }
        else {
            self.errorMessage(title: "Empty Fields", message: "Must fill out all fields")
        }
    }

    @IBAction func newPasswordBtn(_ sender: Any) {
        if nameTxtField!.text! != "" {
            Auth.auth().sendPasswordReset(withEmail: nameTxtField!.text!) { (error) in
                if error == nil {
                    self.errorMessage(title: "Email Sent", message: "Please check your email")
                }
                else {
                    self.errorMessage(title: "Reset Error", message: "Error sending reset password")
                }
            }
        }
        else {
            self.errorMessage(title: "Enter Email", message: "Fill out the email box and then reset password")
        }
        
    }
    
    func errorMessage(title: String, message: String) {
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        self.alertController!.addAction(cancelAction)
        self.present(self.alertController!, animated: true, completion: nil)
    }
}
