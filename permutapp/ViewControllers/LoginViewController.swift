//
//  LoginViewController.swift
//  permutapp
//
//  Created by Maria Jesus Cadenas Sanchez on 04/05/2020.
//  Copyright © 2020 DlgaETSII. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            setUpElements()
        }
        
    func setUpElements(){
        // Hide the error label
        errorLabel.alpha = 0
               
        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }

    //Check the fields and validate that data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error messages.
       
       func validateField () -> String?{
       
           //Check that all fields are filled in
           if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
               return "Por favor, introduce todos los datos."
           }
           // Check if the password is secure
           let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           
           if Utilities.isPasswordValid(cleanedPassword) == false {
               //Password isn't secure enough
               return "Por favor, comprueba que tu contraseña tiene al menos 8 caracteres, y contiene un número y un símbolo."
           }
           return nil
       }
    
    @IBAction func loginTapped(_ sender: Any) {
        //Validate the fields
        let error = validateField()
            
        if error != nil {
            //There's something wrong with the fields, show error message
            showError(error!)
        } else {
            
            // Create cleaned versions of the text field
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
            // Signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    
                if error != nil {
                    // Couldn't sign in
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                } else {
                    self.transitionToHome()
                }
            }
        }
    }
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
               
               view.window?.rootViewController = homeViewController
               view.window?.makeKeyAndVisible()
    }
    
}
