//
//  IntroViewController.swift
//  ClassCalcBTCApp
//
//  Created by Ghayth Kubaisi on 2/13/19.
//  Copyright © 2019 Ghayth Kubaisi. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var nameTextField: DesignableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
    }
    @IBAction func RegisterButtonPressed(_ sender: Any) {
        //check if the textfield content is not empty
        if !nameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            UserDefaults.standard.set(nameTextField.text, forKey: "userName") //save the user name
            UserDefaults.standard.set(true, forKey: "isRegisterd") // save that the user have already registered to set the default screen on the next time the app lunches
            performSegue(withIdentifier: "newuserisregistered", sender: self) // move to currency choosing view
            
        }
    }

    

  

}
