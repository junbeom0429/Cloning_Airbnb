//
//  RegistrationViewController.swift
//  airbnb
//
//  Created by JB on 2021/05/26.
//

import UIKit

class RegistrationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        regiConfig()
    }
    // MARK: 변수
    
    
    // MARK: 아웃렛
    @IBOutlet weak var firstNameTextFieldOutlet: UITextField!
    @IBOutlet weak var lastNameTextFieldOutlet: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    // MARK: 액션
    // 뒤로가기 버튼
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    // 이름 입력창 터치
    @IBAction func firstNameTextFieldTouch(_ sender: Any) {
        
    }
    
    // 이름 입력창 변경시
    @IBAction func firstNameTextFieldChanged(_ sender: Any) {
        print(firstNameTextFieldOutlet.text!)
        UserInform.firstName = firstNameTextFieldOutlet.text!
    }
    
    
    // 성 입력창 터치
    @IBAction func lastNameTextFieldTouch(_ sender: Any) {
    }
    
    
    // 성 입력창 내용 변경시
    @IBAction func lastNameTextFieldChanged(_ sender: Any) {
        print(lastNameTextFieldOutlet.text!)
        UserInform.lastName = lastNameTextFieldOutlet.text!
    }
    
    
    // MARK: 함수
    func regiConfig() {
        emailLabel.text = UserInform.email
    }
    
}
