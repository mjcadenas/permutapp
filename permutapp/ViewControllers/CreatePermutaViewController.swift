//
//  CreatePermutaViewController.swift
//  permutapp
//
//  Created by Maria Jesus Cadenas Sanchez on 08/05/2020.
//  Copyright © 2020 DlgaETSII. All rights reserved.
//

import UIKit
import Firebase

class CreatePermutaViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var courseTextField: UITextField!
    
    @IBOutlet weak var groupOriginTextField: UITextField!
    
    @IBOutlet weak var groupDestineTextField: UITextField!

    @IBOutlet weak var createPermutaButton: UIButton!

    let courseList = ["1","2","3","4"]
    let groupOriginList = ["1","2","3","4","5"]
    let groupDestineList = ["1","2","3","4","5"]
    var coursePicker = UIPickerView()
    var groupOriginPicker = UIPickerView()
    var groupDestinePicker = UIPickerView()
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coursePicker.delegate = self
        coursePicker.dataSource = self
        courseTextField.inputView = coursePicker
        courseTextField.textAlignment = .center
        
        groupOriginPicker.delegate = self
        groupOriginPicker.dataSource = self
        groupOriginTextField.inputView = groupOriginPicker
        groupOriginTextField.textAlignment = .center
        
        groupDestinePicker.delegate = self
        groupDestinePicker.dataSource = self
        groupDestineTextField.inputView = groupDestinePicker
        groupDestineTextField.textAlignment = .center
        
        setUpElements()
    }
    func setUpElements(){
        // Hide the error label
        errorLabel.alpha = 0
               
        // Style the elements
        Utilities.styleTextField(courseTextField)
        Utilities.styleTextField(groupOriginTextField)
        Utilities.styleTextField(groupDestineTextField)
        Utilities.styleFilledButton(createPermutaButton)
    }
    
    func validateField () -> String?{
    
        //Check that all fields are filled in
        if courseTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            groupOriginTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            groupDestineTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Por favor, introduce todos los datos."
        }

        return nil
    }
   
    @IBAction func createPermutaTapped(_ sender: Any) {
    //Validate the fields
        let error = validateField()
           
        if error != nil {
            //There's something wrong with the fields, show error message
        showError(error!)
        } else {
            //Create cleaned versions of the data
            let course = courseTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let groupOrigin = groupOriginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let groupDestine = groupDestineTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if groupOrigin == groupDestine {
                showError("El grupo origen no puede coincidir con el grupo destino.")
        } else {
            //Create the permuta
                let db = Firestore.firestore()
                let newPermuta = db.collection("permutas").document()
                newPermuta.setData(["course": course, "groupOrigin": groupOrigin, "groupDestine": groupDestine]) { (error) in
                        if error != nil{
                        //Show error message
                        self.showError("Error creando la permuta.")
                        } else {
                             print("Permuta creada correctamente")
                        }
                   
                }
                //Transition to the home screen
                self.transitionToHome()
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
        if pickerView == coursePicker{
            return courseList.count
        } else if pickerView == groupOriginPicker {
            return groupOriginList.count
        } else {
            return groupDestineList.count
        }
      }
    
      // The data to return for the row and component (column) that's being passed in
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       if pickerView == coursePicker{
          return courseList[row]
           } else if pickerView == groupOriginPicker {
               return groupOriginList[row]
           } else {
               return groupDestineList[row]
           }
      }
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == coursePicker{
          courseTextField.text = courseList[row]
          courseTextField.resignFirstResponder()
        }else if pickerView == groupOriginPicker{
            groupOriginTextField.text = groupOriginList[row]
            groupOriginTextField.resignFirstResponder()
        } else {
            groupDestineTextField.text = groupOriginList[row]
            groupDestineTextField.resignFirstResponder()
        }
      }
    
    
}
