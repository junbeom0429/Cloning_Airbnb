//
//  RegistrationAgreementVC.swift
//  airbnb
//
//  Created by JB on 2021/05/29.
//

import UIKit

class RegistrationAgreementVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func backBtnTouch(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelBtnTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeBtnTouch(_ sender: Any) {
        UserInform.isLogin = true
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        let tab = main.instantiateInitialViewController()
        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
            self.changeRootViewController(tab!)
        })
    }
    
}
