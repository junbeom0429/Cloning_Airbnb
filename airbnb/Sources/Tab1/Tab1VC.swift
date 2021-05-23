//
//  Tab1VC.swift
//  airbnb
//
//  Created by JB on 2021/05/23.
//

import UIKit

class Tab1VC: BaseViewController {
    
    @IBAction func goToLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "tab1ToLogin", sender: self)
    }
    
    
    override func viewDidLoad() {
        
    }
}
