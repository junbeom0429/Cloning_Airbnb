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
    }
    // MARK: - Header Container
    
    // MARK: - Sign Up Container
    // 변수
    var constraints: [NSLayoutConstraint] = []
    var isShowed = false
    var showedHighlightView = UIView()
    
    // 아웃렛
    @IBOutlet weak var signUpContainer: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var highlightView1: UIView!
    @IBOutlet weak var highlightView2: UIView!
    @IBOutlet weak var ContinueBtn: UIButton!
    @IBOutlet weak var signUpStackView: UIStackView!
    
    // 액션
    @IBAction func touchCountryBtn(_ sender: Any) {
        showHighlightView(target: countryView, highlight: highlightView1)
        moveHighlightView(target: countryView)
        
    }
    @IBAction func touchPhoneNumberBtn(_ sender: Any) {
        showHighlightView(target: phoneNumberView, highlight: highlightView2)
        moveHighlightView(target: phoneNumberView)
    }
    
    // 첫 터치시 뷰 보이기
    func showHighlightView(target: UIView, highlight: UIView) {
        if isShowed == false {
            UIView.animate(withDuration: 0.15) {
                highlight.layer.borderWidth = 2
//                highlight.layer.cornerRadius = 10
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
        
        
//        countryView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        countryView.layer.cornerRadius = 10
//        countryView.layer.borderWidth = 1
//        countryView.layer.borderColor = UIColor.darkGray.cgColor
//        countryView.layer.addBorder([.top,.left,.right], color: .darkGray, width: 1)
        
        
        phoneNumberView.layer.cornerRadius = 10
        phoneNumberView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        phoneNumberView.layer.borderWidth = 1
        phoneNumberView.layer.borderColor = UIColor.borderLightGray.cgColor
        
        highlightView1.layer.cornerRadius = 10
        highlightView2.layer.cornerRadius = 10
        
    }
    
    // MARK: - LoginAPI Container
    // 변수
    var isEmail = false
    var loginAPIConstraints: [NSLayoutConstraint] = []
    
    // 아웃렛
    @IBOutlet weak var loginAPIContainer: UIView!
    @IBOutlet weak var emailContainer: UIView!
    @IBOutlet weak var LoginAPITopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailBtn: UIButton!
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
        emailBtn.layer.cornerRadius = 5
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
