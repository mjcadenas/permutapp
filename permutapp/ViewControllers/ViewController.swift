//
//  ViewController.swift
//  permutapp
//
//  Created by Maria Jesus Cadenas Sanchez on 04/05/2020.
//  Copyright © 2020 DlgaETSII. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements(){
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }


}

