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
import FirebaseCore


class SignUpViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var uvusTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var gradeTextField: UITextField!
    
    let gradeList = ["ISW", "TI", "IC", "ISA"]

    var gradePicker = UIPickerView()
     
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Connect data:
        gradePicker.delegate = self
        gradePicker.dataSource = self
        gradeTextField.inputView = gradePicker
        gradeTextField.textAlignment = .center
             
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
      public func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      // The number of rows of data
      public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return gradeList.count
      }
    
      // The data to return for the row and component (column) that's being passed in
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return gradeList[row]
      }
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          gradeTextField.text = gradeList[row]
          gradeTextField.resignFirstResponder()
      }
      
}
