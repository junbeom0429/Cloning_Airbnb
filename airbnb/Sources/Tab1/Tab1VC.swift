//
//  Tab1VC.swift
//  airbnb
//
//  Created by JB on 2021/05/23.
//

import UIKit

class Tab1VC: BaseViewController {
    override func viewDidLoad() {
        suggestLogin()
    }
    // MARK: - 프로퍼티
    
    
    // MARK: - 아웃렛
    @IBOutlet weak var wishListItemBtnOutlet: UIButton!
    
    
    
    // MARK: - 액션
    @IBAction func wishListItemBtnTouch(_ sender: UIButton) {
        sender.pulsate()
    }
    
    @IBAction func hostItemBtnTouch(_ sender: UIButton) {
        sender.pulsate()
    }
    
    
    // MARK: - 함수
    func config() {
        
    }
    
    func suggestLogin() {
        if UserInform.isLogin == false {
            performSegue(withIdentifier: "tab1ToLogin", sender: self)
        }
    }
}

