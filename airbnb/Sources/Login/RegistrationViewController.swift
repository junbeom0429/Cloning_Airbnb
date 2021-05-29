//
//  RegistrationViewController.swift
//  airbnb
//
//  Created by JB on 2021/05/26.
//

import UIKit
import SnapKit

class RegistrationViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        regiConfig()

    }
    
    // MARK: - 프로퍼티
    var isCheck = false
    var isPickerShowed = false
    var isSecure = true
    var isSecurityFailShowed = true
    
    // MARK: - 아웃렛
    @IBOutlet weak var firstNameTextFieldOutlet: UITextField!
    @IBOutlet weak var lastNameTextFieldOutlet: UITextField!
    @IBOutlet weak var PWTextFieldOutlet: UITextField!
    
    @IBOutlet weak var birthOutlet: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var checkBtnOutlet: UIButton!
    @IBOutlet weak var birthBtnOutlet: UIButton!
    

    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var securityView: UIView!
    @IBOutlet weak var bottomAlertView: UIView!
    
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var securityFail: UIImageView!
    
    @IBOutlet weak var PWCountValidationAspect: NSLayoutConstraint!
    @IBOutlet weak var PWCountValidationHeight: NSLayoutConstraint!
    @IBOutlet weak var PWLetterValidationHeight: NSLayoutConstraint!
    @IBOutlet weak var PWLetterValidationAspect: NSLayoutConstraint!
    @IBOutlet weak var bottomAlertTop: NSLayoutConstraint!
    
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
        
        let text = PWTextFieldOutlet.text!
        let countRegex = Regex.shared.checkPWCountValidation(candidate: text)

        let letterRegex = Regex.shared.checkPWLetterValidation(candidate: text)
        
        if countRegex == true {
            PWCountValidationHeight.priority = .required
            
            //super.updateViewConstraints()
            UIViewPropertyAnimator(duration: 0.1, curve: .easeOut) {
                self.view.layoutIfNeeded()
            }.startAnimation()
        } else {
            PWCountValidationHeight.priority = .defaultLow
            
            //super.updateViewConstraints()
            UIViewPropertyAnimator(duration: 0.1, curve: .easeOut) {
                self.view.layoutIfNeeded()
            }.startAnimation()
        }
        if letterRegex == true {
            PWLetterValidationHeight.priority = .required
            
            //super.updateViewConstraints()
            UIViewPropertyAnimator(duration: 0.1, curve: .easeOut) {
                self.view.layoutIfNeeded()
            }.startAnimation()
        } else {
            PWLetterValidationHeight.priority = .defaultLow
            
            //super.updateViewConstraints()
            UIViewPropertyAnimator(duration: 0.1, curve: .easeOut) {
                self.view.layoutIfNeeded()
            }.startAnimation()
        }
        
        if letterRegex && countRegex == true {
            // 보안 좋음 보여주기
            if isSecurityFailShowed == true {
                UIView.animate(withDuration: 0.1) {
                    self.securityFail.alpha = 1
                    self.securityFail.alpha = 0
                }
            }
            isSecurityFailShowed = false
            
            // 패스워드 저장
            UserInform.password = PWTextFieldOutlet.text!
        } else {
            // 보안 낮음 보여주기
            if isSecurityFailShowed == false {
                UIView.animate(withDuration: 0.1) {
                    self.securityFail.alpha = 0
                    self.securityFail.alpha = 1
                }
                isSecurityFailShowed = true
            }
        }
        
        print(PWTextFieldOutlet.text!)
    }
    
    // 비밀번호창 표시 버튼
    @IBAction func showPWBtn(_ sender: Any) {
        if isSecure == true {
            PWTextFieldOutlet.isSecureTextEntry = false
            isSecure = false
        } else {
            PWTextFieldOutlet.isSecureTextEntry = true
            isSecure = true
        }
    }
    
    // 동의 버튼
    @IBAction func agreeBtnTouch(_ sender: Any) {
        agreeValidation()
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
        UserInform.birthDay = datePickerOutlet.date.text
        birthOutlet.text = datePickerOutlet.date.text
    }
    // MARK: - 함수
    func regiConfig() {
        emailLabel.text = UserInform.email
        
        // 하단 경고창
        bottomAlertView.layer.cornerRadius = 10
        bottomAlertView.layer.shadowColor = UIColor.black.cgColor
        bottomAlertView.layer.shadowRadius = 10
        bottomAlertView.layer.shadowOffset = .zero
        bottomAlertView.layer.shadowOpacity = 0.15
        bottomAlertView.layer.shouldRasterize = true
        
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
    
    func agreeValidation() {
        if UserInform.firstName != "" && UserInform.lastName != "" && UserInform.birthDay != "" && UserInform.password != "" {
            // 다음 뷰로 이동
            
            performSegue(withIdentifier: "goToNext", sender: nil)
                
            
            
            
        } else {
            // 하단경고창 팝업
            popUpBottonAlert()
        }
    }
    func popUpBottonAlert() {
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeIn) {
            self.bottomAlertTop.priority = .defaultLow
            self.view.layoutIfNeeded()
        }
        let backward = UIViewPropertyAnimator(duration: 0.15, curve: .easeIn) {
            self.bottomAlertTop.priority = .required
            self.view.layoutIfNeeded()
        }

        animator.addCompletion { _ in
                backward.startAnimation(afterDelay: 2)
        }
        animator.startAnimation()
    }
}

// MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        setupTextFieldsAccessoryView(textField)
        dismissDatePicker()
        switch textField {
                case firstNameTextFieldOutlet:
                    scrollView.scroll(to: .top)
                case PWTextFieldOutlet:
                    scrollView.scroll(to: .bottom)
                default:
                    break
        }
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


