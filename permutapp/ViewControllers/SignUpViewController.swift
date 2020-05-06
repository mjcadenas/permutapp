//
//  SingUpViewController.swift
//  permutapp
//
//  Created by Maria Jesus Cadenas Sanchez on 04/05/2020.
//  Copyright © 2020 DlgaETSII. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var uvusTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var gradeTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
        //Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(uvusTextField)
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(gradeTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    //Check the fields and validate that data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error messages.
    
    func validateField () -> String?{
    
        //Check that all fields are filled in
        if  uvusTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            firstNameTextField.text?.trimmingCharacters(in: .newlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .newlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            gradeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
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
    
    
   

    @IBAction func signUpTapped(_ sender: Any) {
        //Validate the fields
        let error = validateField()
        
        if error != nil {
            //There's something wrong with the fields, show error message
            showError(error!)
            
        } else {
            //Create cleaned versions of the data
            let uvus = uvusTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .newlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .newlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let grade = gradeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password){ (result, err) in
                //Check for errors
                if err != nil {
                    //There was an error creating the user
                    self.showError("Error creando usuario.")
                } else {
                    //User was created succesfully, now store the rest.
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["uvus": uvus, "firstname": firstName, "lastname": lastName,  "grade": grade, "uid": result!.user.uid]) { (error) in
                        if error != nil{
                            //Show error message
                            self.showError("Error guardando los datos del usuario.")
                        }
                    }
                    //Transition to the home screen
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
