//
//  Login.swift
//  airbnb
//
//  Created by JB on 2021/05/23.
//

import UIKit
import SnapKit
import GoogleSignIn
import FBSDKLoginKit

class LoginVC: BaseViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        LoginAPIConfig()
        signUpContainerConfig()
        emailContainerConfig()
        GIDSignIn.sharedInstance()?.presentingViewController = self // 로그인화면 불러오기
        GIDSignIn.sharedInstance()?.restorePreviousSignIn() // 자동로그인
        if let token = AccessToken.current, !token.isExpired { /* User is logged in, do work such as go to next view controller*/ }
        //키보드 노티피케이션
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // 뷰 bottom constant
    @IBOutlet weak var scrollViewBottom: NSLayoutConstraint!
    
    // 키보드에 따른 뷰높이 조절
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom
            scrollViewBottom.constant = adjustmentHeight
        } else {
            scrollViewBottom.constant = 0
        }
    }
    
    // MARK: - Header Container
    @IBAction func quitBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Sign Up Container
    // 변수
    var constraints: [NSLayoutConstraint] = []
    var PNConstraints:  [NSLayoutConstraint] = []
    var phoneNumRegex = false
    
    var isShowed = false
    var showedHighlightView = UIView()
    var ismoved = false
    
    // 아웃렛
    @IBOutlet weak var signUpContainer: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var highlightView1: UIView!
    @IBOutlet weak var highlightView2: UIView!
    @IBOutlet weak var ContinueBtn: UIButton!
    @IBOutlet weak var signUpStackView: UIStackView!
    @IBOutlet weak var phoneNumberOriginLoc: UIView!
    @IBOutlet weak var phoneNumberTargetLoc: UIView!
    @IBOutlet weak var countryInfoLabel: UILabel!
    
    
    @IBOutlet weak var originLocTop: NSLayoutConstraint!
    @IBOutlet weak var originLocLeading: NSLayoutConstraint!
    @IBOutlet weak var originLocHeight: NSLayoutConstraint!
    @IBOutlet weak var originLocWidth: NSLayoutConstraint!
    @IBOutlet weak var phoneNumTextField: UITextField!
    
    // MARK: 액션
    @IBAction func touchCountryBtn(_ sender: Any) {
        showHighlightView(target: countryView, highlight: highlightView1)
        moveHighlightView(target: countryView)
    }
    //핸드폰번호 입력창 터치 액션
    @IBAction func touchPhoneNumberBtn(_ sender: Any) {
        showHighlightView(target: phoneNumberView, highlight: highlightView2)
        moveHighlightView(target: phoneNumberView)
        movePN(target: phoneNumberTargetLoc)
        phoneNumTextField.becomeFirstResponder()
    }
    @IBAction func continueBtnAction(_ sender: Any) {
        print("continueBtnAction called")
//        performSegue(withIdentifier: "goToRegi", sender: self)
    }
    
    
    
    // MARK: 함수
    func movePN(target: UIView) {
        if ismoved == false {
            phoneNumberView.removeConstraint(originLocLeading)
            phoneNumberView.removeConstraint(originLocTop)
            phoneNumberOriginLoc.removeConstraint(originLocHeight)
            phoneNumberOriginLoc.removeConstraint(originLocWidth)
            phoneNumberOriginLoc.translatesAutoresizingMaskIntoConstraints = false
            PNConstraints = [
                phoneNumberOriginLoc.leadingAnchor.constraint(equalTo: target.leadingAnchor),
                phoneNumberOriginLoc.trailingAnchor.constraint(equalTo: target.trailingAnchor),
                phoneNumberOriginLoc.topAnchor.constraint(equalTo: target.topAnchor),
                phoneNumberOriginLoc.bottomAnchor.constraint(equalTo: target.bottomAnchor)
            ]
            NSLayoutConstraint.activate(PNConstraints)
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
            ismoved = true
        }
    }
    // 첫 터치시 뷰 보이기
    func showHighlightView(target: UIView, highlight: UIView) {
        if isShowed == false {
            UIView.animate(withDuration: 0.15) {
                highlight.layer.borderWidth = 2
                highlight.layer.borderColor = UIColor.black.cgColor
            }
            isShowed = true
            showedHighlightView = highlight
        }
    }

    // 하이라이트뷰 이동
    func moveHighlightView(target: UIView) {
        if isShowed == true {
            NSLayoutConstraint.deactivate(constraints)
            showedHighlightView.translatesAutoresizingMaskIntoConstraints = false
            constraints = [ showedHighlightView.leadingAnchor.constraint(equalTo: target.leadingAnchor), showedHighlightView.trailingAnchor.constraint(equalTo: target.trailingAnchor),
                showedHighlightView.topAnchor.constraint(equalTo: target.topAnchor),
                showedHighlightView.bottomAnchor.constraint(equalTo: target.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
    // 컨피그
    func signUpContainerConfig() {
        ContinueBtn.layer.cornerRadius = 10
              
        phoneNumberView.layer.cornerRadius = 10
        phoneNumberView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        phoneNumberView.layer.borderWidth = 1
        phoneNumberView.layer.borderColor = UIColor.borderLightGray.cgColor
        
        highlightView1.layer.cornerRadius = 10
        highlightView2.layer.cornerRadius = 10
        
    }
    
    
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
    
    // MARK: Textfield Delegate
    // 입력된 스트링 확인
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(textField.text!)
        
        if textField == phoneNumTextField {
            let inputNum = textField.text!
            let isRegex = Regex.shared.isPhone(candidate: inputNum)
            if isRegex == true {
                changeCountinueBtnActivityStatus(true, btn: ContinueBtn)
            } else {
                changeCountinueBtnActivityStatus(false, btn: ContinueBtn)
            }
        } else if textField == emailTextField {
            let inputNum = textField.text!
            let isRegex = Regex.shared.isEmail(candidate: inputNum)
            if isRegex == true {
                changeCountinueBtnActivityStatus(true, btn: emailContinueBtn)
            } else {
                changeCountinueBtnActivityStatus(false, btn: emailContinueBtn)
            }
        }
    }
    
    // 키보드 위에 툴바뷰 붙이기
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == phoneNumTextField {
            setupTextFieldsAccessoryView(phoneNumTextField)
        } else if textField == emailTextField {
            setupTextFieldsAccessoryView(emailTextField)
        }
            
            return true
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
        
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(didPressDoneButton))
        doneButton.tintColor = UIColor.darkGray
        toolBar.items = [flexsibleSpace, doneButton]
        
        textFieldName.inputAccessoryView = toolBar
    }
    
    // 툴바 done버튼 클릭
    @objc func didPressDoneButton(button: UIButton) {
        phoneNumTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
    // MARK: - Email Container
    //변수
    var isEmailHighlighted = false
    var isTouchedEmail = false
    var emailConstraints: [NSLayoutConstraint] = []

    
    //아웃렛
    @IBOutlet weak var emailContainer: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var highlightView3: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailContinueBtn: UIButton!
    @IBOutlet weak var emailOriginLoc: UIView!
    @IBOutlet weak var emailTargetLoc: UIView!
    
    @IBOutlet weak var emailHeight: NSLayoutConstraint!
    @IBOutlet weak var emailWidth: NSLayoutConstraint!
    @IBOutlet weak var emailTop: NSLayoutConstraint!
    @IBOutlet weak var emailLeading: NSLayoutConstraint!
    
    // MARK: 액션
    @IBAction func emailViewAction(_ sender: Any) {
        moveEmail(target: emailTargetLoc)
        showEmailHighlight(highlight: highlightView3)
        emailTextField.becomeFirstResponder()
    }
    @IBAction func emailContinueBtnAction(_ sender: Any) {
        emailTextField.resignFirstResponder()
        UserInform.email = emailTextField.text!
        performSegue(withIdentifier: "goToRegi", sender: self)
    }
    
    
    // MARK: 함수
    func moveEmail(target: UIView) {
        if isTouchedEmail == false {
            emailView.removeConstraint(emailTop)
            emailView.removeConstraint(emailLeading)
            emailOriginLoc.removeConstraint(emailHeight)
            emailOriginLoc.removeConstraint(emailWidth)
            emailOriginLoc.translatesAutoresizingMaskIntoConstraints = false
            emailConstraints = [
                emailOriginLoc.leadingAnchor.constraint(equalTo: target.leadingAnchor),
                emailOriginLoc.trailingAnchor.constraint(equalTo: target.trailingAnchor),
                emailOriginLoc.topAnchor.constraint(equalTo: target.topAnchor),
                emailOriginLoc.bottomAnchor.constraint(equalTo: target.bottomAnchor)
            ]
            NSLayoutConstraint.activate(emailConstraints)
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
            isTouchedEmail = true
        }
    }
    
    func showEmailHighlight(highlight: UIView) {
        if isEmailHighlighted == false {
            UIView.animate(withDuration: 0.15) {
                highlight.layer.borderWidth = 2
                highlight.layer.borderColor = UIColor.black.cgColor
            }
            isEmailHighlighted = true
        }
    }
    
    func emailContainerConfig() {
        emailContinueBtn.layer.cornerRadius = 10
        
        highlightView3.layer.cornerRadius = 10
        
        emailView.layer.cornerRadius = 10
        emailView.layer.borderWidth = 1
        emailView.layer.borderColor = UIColor.borderLightGray.cgColor
    }
    
    // MARK: - LoginAPI Container
    // 변수
    var isEmail = false
    var loginAPIConstraints: [NSLayoutConstraint] = []
    
    // 아웃렛
    @IBOutlet weak var loginAPIContainer: UIView!
    @IBOutlet weak var LoginAPITopConstraint: NSLayoutConstraint!
    @IBOutlet weak var appleBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var emailOutlet: UIView!
    @IBOutlet weak var phoneOutlet: UIView!
    @IBOutlet weak var appleOutlet: UIView!
    @IBOutlet weak var googleOutlet: UIView!
    @IBOutlet weak var facebookOutlet: UIView!
    
    
    // MARK: 액션
    @IBAction func touchLoginWithEmail(_ sender: Any) {
        showEmailContainer()
        phoneNumTextField.resignFirstResponder()
    }
    @IBAction func googleLoginAction(_ sender: Any) {
        googleLogin()
    }
    @IBAction func facebookLoginAction(_ sender: Any) {
        LoginManager().logIn()
    }

    
    // 함수
    func showEmailContainer() {
        if isEmail == false {
            signUpContainer.isHidden = true
            signUpContainer.alpha = 0
            emailContainer.isHidden = false
            emailContainer.alpha = 0
            emailOutlet.isHidden = true
            phoneOutlet.isHidden = false
            
            NSLayoutConstraint.deactivate(loginAPIConstraints)
            loginAPIContainer.translatesAutoresizingMaskIntoConstraints = false
            loginAPIConstraints = [
                loginAPIContainer.topAnchor.constraint(equalTo: emailContainer.bottomAnchor)
            ]
            NSLayoutConstraint.activate(loginAPIConstraints)
            
            UIView.animate(withDuration: 0.3) {
                self.emailContainer.alpha = 1
                self.view.layoutIfNeeded()
            }
            isEmail = true
        } else if isEmail == true {
            signUpContainer.isHidden = false
            emailContainer.isHidden = true
            emailContainer.alpha = 0
            phoneOutlet.isHidden = true
            emailOutlet.isHidden = false
            
            NSLayoutConstraint.deactivate(loginAPIConstraints)
            loginAPIContainer.translatesAutoresizingMaskIntoConstraints = false
            loginAPIConstraints = [
                loginAPIContainer.topAnchor.constraint(equalTo: signUpContainer.bottomAnchor)
            ]
            NSLayoutConstraint.activate(loginAPIConstraints)
            
            UIView.animate(withDuration: 0.3) {
                self.signUpContainer.alpha = 1
                self.view.layoutIfNeeded()
            }
            isEmail = false
        }
    }

    // MARK: 구글 로그인
    func googleLogin() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    func googleLogout() {
        GIDSignIn.sharedInstance()?.signOut()
    }
    // MARK: 페이스북
    func facebookLogin() {
        LoginManager().logIn()
    }
    func facebookLogout() {
        LoginManager().logOut()
    }
    
    func changeBackgroundColorWhenTouchDown(btn: UIButton) {
        UIView.animate(withDuration: 0.2) {
            btn.backgroundColor = UIColor.red
        }
    }
    func changeBGColorWhenTouchCancel(btn: UIButton) {
        UIView.animate(withDuration: 0.2) {
            btn.backgroundColor = UIColor.clear
        }
    }
    func LoginAPIConfig() {
        emailOutlet.layer.cornerRadius = 10
        emailOutlet.layer.borderWidth = 0.5
        emailOutlet.layer.borderColor = UIColor.darkGray.cgColor
        phoneOutlet.layer.cornerRadius = 10
        phoneOutlet.layer.borderWidth = 0.5
        phoneOutlet.layer.borderColor = UIColor.darkGray.cgColor
        
        appleOutlet.layer.cornerRadius = 10
        appleBtn.layer.cornerRadius = 10
        appleOutlet.layer.borderWidth = 0.5
        appleOutlet.layer.borderColor = UIColor.darkGray.cgColor
        
        googleOutlet.layer.cornerRadius = 10
        googleBtn.layer.cornerRadius = 10
        googleOutlet.layer.borderWidth = 0.5
        googleOutlet.layer.borderColor = UIColor.darkGray.cgColor
        
        facebookOutlet.layer.cornerRadius = 10
        facebookBtn.layer.cornerRadius = 10
        facebookOutlet.layer.borderWidth = 0.5
        facebookOutlet.layer.borderColor = UIColor.darkGray.cgColor
    }
}
