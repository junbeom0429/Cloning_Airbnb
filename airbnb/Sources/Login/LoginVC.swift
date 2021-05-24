//
//  Login.swift
//  airbnb
//
//  Created by JB on 2021/05/23.
//

import UIKit
import SnapKit

class LoginVC: BaseViewController {
    override func viewDidLoad() {
        LoginAPIConfig()
        signUpContainerConfig()
        emailContainerConfig()
    }
    // MARK: - Header Container
    

    // MARK: - Sign Up Container
    // 변수
    var constraints: [NSLayoutConstraint] = []
    var PNConstraints:  [NSLayoutConstraint] = [
        
    ]
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
    @IBOutlet weak var originLocTop: NSLayoutConstraint!
    @IBOutlet weak var originLocLeading: NSLayoutConstraint!
    @IBOutlet weak var originLocHeight: NSLayoutConstraint!
    @IBOutlet weak var originLocWidth: NSLayoutConstraint!
    @IBOutlet weak var phoneNumTextField: UITextField!
    
    // 액션
    @IBAction func touchCountryBtn(_ sender: Any) {
        showHighlightView(target: countryView, highlight: highlightView1)
        moveHighlightView(target: countryView)
        
    }
    @IBAction func touchPhoneNumberBtn(_ sender: Any) {
        showHighlightView(target: phoneNumberView, highlight: highlightView2)
        moveHighlightView(target: phoneNumberView)
        movePN(target: phoneNumberTargetLoc)
        phoneNumTextField.becomeFirstResponder()
    }
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
    func signUpContainerConfig() {
        ContinueBtn.layer.cornerRadius = 10
              
        phoneNumberView.layer.cornerRadius = 10
        phoneNumberView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        phoneNumberView.layer.borderWidth = 1
        phoneNumberView.layer.borderColor = UIColor.borderLightGray.cgColor
        
        highlightView1.layer.cornerRadius = 10
        highlightView2.layer.cornerRadius = 10
        
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
    
    //액션
    @IBAction func emailViewAction(_ sender: Any) {
        moveEmail(target: emailTargetLoc)
        showEmailHighlight(highlight: highlightView3)
        emailTextField.becomeFirstResponder()
    }
    
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
    @IBOutlet weak var appleOutlet: UIView!
    @IBOutlet weak var googleOutlet: UIView!
    @IBOutlet weak var facebookOutlet: UIView!
    
    
    // 액션
    @IBAction func touchLoginWithEmail(_ sender: Any) {
        if isEmail == false {
            self.signUpContainer.isHidden = true
            self.signUpContainer.alpha = 0
            self.emailContainer.isHidden = false
            self.emailContainer.alpha = 0
            
            NSLayoutConstraint.deactivate(loginAPIConstraints)
            loginAPIContainer.translatesAutoresizingMaskIntoConstraints = false
            loginAPIConstraints = [
                self.loginAPIContainer.topAnchor.constraint(equalTo: self.emailContainer.bottomAnchor)
            ]
            NSLayoutConstraint.activate(loginAPIConstraints)
            
            UIView.animate(withDuration: 0.3) {
                self.emailContainer.alpha = 1
                self.view.layoutIfNeeded()
            }
            isEmail = true
        } else if isEmail == true {
            self.signUpContainer.isHidden = false
            self.emailContainer.isHidden = true
            self.emailContainer.alpha = 0
            
            NSLayoutConstraint.deactivate(loginAPIConstraints)
            loginAPIContainer.translatesAutoresizingMaskIntoConstraints = false
            loginAPIConstraints = [
                self.loginAPIContainer.topAnchor.constraint(equalTo: self.signUpContainer.bottomAnchor)
            ]
            NSLayoutConstraint.activate(loginAPIConstraints)
            
            UIView.animate(withDuration: 0.3) {
                self.signUpContainer.alpha = 1
                self.view.layoutIfNeeded()
            }
            isEmail = false
        }
    }
    
    @IBAction func touchDown(_ sender: UIButton) {
        changeBackgroundColorWhenTouchDown(btn: sender)
    }
    @IBAction func touchCancel(_ sender: UIButton) {
        changeBGColorWhenTouchCancel(btn: sender)
    }
    
    func changeBackgroundColorWhenTouchDown(btn: UIButton) {
        UIView.animate(withDuration: 0.2) {
            btn.backgroundColor = UIColor.lightGray
        }
    }
    func changeBGColorWhenTouchCancel(btn: UIButton) {
        UIView.animate(withDuration: 0.2) {
            btn.backgroundColor = UIColor.clear
        }
    }
    func LoginAPIConfig() {
        emailOutlet.layer.cornerRadius = 5
        emailOutlet.layer.borderWidth = 0.5
        emailOutlet.layer.borderColor = UIColor.darkGray.cgColor
        
        appleOutlet.layer.cornerRadius = 5
        appleBtn.layer.cornerRadius = 5
        appleOutlet.layer.borderWidth = 0.5
        appleOutlet.layer.borderColor = UIColor.darkGray.cgColor
        
        googleOutlet.layer.cornerRadius = 5
        googleBtn.layer.cornerRadius = 5
        googleOutlet.layer.borderWidth = 0.5
        googleOutlet.layer.borderColor = UIColor.darkGray.cgColor
        
        facebookOutlet.layer.cornerRadius = 5
        facebookBtn.layer.cornerRadius = 5
        facebookOutlet.layer.borderWidth = 0.5
        facebookOutlet.layer.borderColor = UIColor.darkGray.cgColor
        
    }
}
