//
//  HomeViewController.swift
//  permutapp
//
//  Created by Maria Jesus Cadenas Sanchez on 04/05/2020.
//  Copyright © 2020 DlgaETSII. All rights reserved.
//
import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    @IBOutlet weak var createPermutaButton: UIButton!
    
    @IBOutlet weak var myPermutasButton: UIButton!
    
    @IBOutlet weak var allPermutasButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        Utilities.styleFilledButton(createPermutaButton)
        Utilities.styleHollowButton(myPermutasButton)
        Utilities.styleFilledButton(allPermutasButton)
    }
    
    
    @IBAction func logOutButton_Tapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateViewController(identifier: "ViewController")
        self.present(initial, animated: true, completion: nil)
       
    }
    
}
