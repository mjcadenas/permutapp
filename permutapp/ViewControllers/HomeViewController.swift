//
//  HomeViewController.swift
//  permutapp
//
//  Created by Maria Jesus Cadenas Sanchez on 04/05/2020.
//  Copyright © 2020 DlgaETSII. All rights reserved.
//
import UIKit

class HomeViewController: UIViewController {

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
    
    

}
