//
//  PasswordViewController.swift
//  airbnb
//
//  Created by JB on 2021/06/01.
//

import UIKit

class PasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var passwordTextView: UITextField!
    
    @IBAction func ContinueBtnTouch(_ sender: Any) {
        
    }
    
    
}

extension PasswordViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        func changeCountinueBtnActivityStatus(_ isRegex: Bool, btn: UIButton) {
            let inActiveImg = UIImage(named: "continueBtnInactive.png")
            let activeImg = UIImage(named: "continueBtn.png")
            if isRegex == true {
                btn.isEnabled = true
                btn.setImage(activeImg, for: .normal)
                btn.reloadInputViews()
            } else {
                btn.isEnabled = false
                btn.setImage(inActiveImg, for: .normal)
                btn.reloadInputViews()
            }
        }
    }
}
