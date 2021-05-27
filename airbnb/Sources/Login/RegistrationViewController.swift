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
    
    // MARK: - 변수
    var isCheck = false
    var isPickerShowed = false
    
    // MARK: - 아웃렛
    @IBOutlet weak var firstNameTextFieldOutlet: UITextField!
    @IBOutlet weak var lastNameTextFieldOutlet: UITextField!
    @IBOutlet weak var PWTextFieldOutlet: UITextField!
    
    @IBOutlet weak var birthOutlet: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var checkBtnOutlet: UIButton!
    @IBOutlet weak var birthBtnOutlet: UIButton!
    

    @IBOutlet weak var datePickerView: UIView!
    
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    
    // MARK: - 액션
    // 뒤로가기 버튼
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // 이름 입력창 변경시
    @IBAction func firstNameTextFieldChanged(_ sender: Any) {
        print(firstNameTextFieldOutlet.text!)
        UserInform.firstName = firstNameTextFieldOutlet.text!
    }
    
    // 성 입력창 내용 변경시
    @IBAction func lastNameTextFieldChanged(_ sender: Any) {
        print(lastNameTextFieldOutlet.text!)
        UserInform.lastName = lastNameTextFieldOutlet.text!
    }
    
    // 생일 피커
    @IBAction func BirthBtnTouch(_ sender: Any) {
        firstNameTextFieldOutlet.resignFirstResponder()
        lastNameTextFieldOutlet.resignFirstResponder()
        PWTextFieldOutlet.resignFirstResponder()
        showDatePicker()
    }
    
    // 비밀번호 입력 변경시
    @IBAction func passwordtextFieldChanged(_ sender: Any) {
        UserInform.password = PWTextFieldOutlet.text!
        print(PWTextFieldOutlet.text!)
    }
    
    // 동의 버튼
    @IBAction func agreeBtnTouch(_ sender: Any) {
        
    }
    
    // 체크 버튼
    @IBAction func checkBtnTouch(_ sender: Any) {
        let img = UIImage(named: "check68.png")
        if isCheck == false {
            checkBtnOutlet.setImage(img, for: .normal)
            UserInform.marketingAgree = true
            isCheck = true
        } else if isCheck == true {
            checkBtnOutlet.setImage(nil, for: .normal)
            UserInform.marketingAgree = false
            isCheck = false
        }
    }
    
    // 데이트피커 다음버튼 터치
    @IBAction func datePickerNextBtnTouch(_ sender: Any) {
        didPressNextButton(button: birthBtnOutlet)
    }
    
    // 데이트피커 입력값 변화시
    @IBAction func datePickerChanged(_ sender: Any) {
        print(datePickerOutlet.date.text)
    }
    // MARK: - 함수
    func regiConfig() {
        emailLabel.text = UserInform.email
    }
    
    // 툴바뷰 생성
    func setupTextFieldsAccessoryView(_ textFieldName: UITextField) {
        guard textFieldName.inputAccessoryView == nil else {
            print("textfields accessory view already set up")
            return
        }
        
        let toolBar: UIToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.barTintColor = UIColor.keyboardLightGray
        
        let flexsibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let nextButton: UIBarButtonItem = UIBarButtonItem(title: "다음", style: .done, target: self, action: #selector(didPressNextButton))
        nextButton.tintColor = UIColor.darkGray
        toolBar.items = [flexsibleSpace, nextButton]
        
        textFieldName.inputAccessoryView = toolBar
    }
    
    // 데이트피커 보여주기
    func showDatePicker() {
        if isPickerShowed == false {
            let view = datePickerView
            datePickerView.alpha = 0
            UIView.animate(withDuration: 0.2) {
                self.datePickerView.alpha = 1
                view?.isHidden = false
            }
        }
        isPickerShowed = true
    }
    
    // 데이트피커 숨기기
    func dismissDatePicker() {
        if isPickerShowed == true {
            let view = datePickerView
            datePickerView.alpha = 1
            UIView.animate(withDuration: 0.2) {
                self.datePickerView.alpha = 0
                view?.isHidden = true
            }
        }
        isPickerShowed = false
    }
    
    // 툴바 next버튼 클릭
    @objc func didPressNextButton(button: UIButton) {
        if firstNameTextFieldOutlet.isFirstResponder {
            lastNameTextFieldOutlet.becomeFirstResponder()
        } else if lastNameTextFieldOutlet.isFirstResponder {
            showDatePicker()
            lastNameTextFieldOutlet.resignFirstResponder()
        } else if isPickerShowed == true {
            dismissDatePicker()
            PWTextFieldOutlet.becomeFirstResponder()
        } else {
            PWTextFieldOutlet.resignFirstResponder()
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        setupTextFieldsAccessoryView(textField)
        dismissDatePicker()
        return true
    }
}

// MARK: - UIGestureRecognizerDelegate
extension RegistrationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("tap!")
        return true
    }
}

// MARK: - UIScrollViewDelegate
extension RegistrationViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isPickerShowed == true {
            dismissDatePicker()
        }
    }
}
