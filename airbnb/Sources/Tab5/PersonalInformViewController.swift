//
//  PersonalInformViewController.swift
//  airbnb
//
//  Created by JB on 2021/05/30.
//

import UIKit

class PersonalInformViewController: BaseViewController {
    static var shared = PersonalInformViewController()
    static var identifier = "goToPersonalInform"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PersonalInformViewController - viewDidLoad")

        config()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("PersonalInformViewController - viewWillAppear")
        // 이미지뷰 업데이트
        guard let PI = UserDefaults.standard.value(forKey: UserDefaultKeyValue.profileImage) as? Data else {return}
        let image = UIImage(data: PI as Data)
        profileImageView.image = image
    }
    
    // MARK: - 프로퍼티
    let imagePicker = UIImagePickerController()
    var isPhoneNumEdited = false
    var isProfileImageEdited = false
    
    // MARK: - 아웃렛
    @IBOutlet weak var profileImageView: UIImageView!
 
    @IBOutlet weak var birthDate: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    
    @IBOutlet weak var addImageView: UIView!
    
    // MARK: - 액션
    // 네비 저장 버튼
    @IBAction func saveBtn() {
        print("clicked SaveBtn")
        save()
    }
    
    // 네비 뒤로 버튼
    @IBAction func backBtn() {
        
        navigationController?.popViewController(animated: true)
    }
    // 프로필이미지 선택
    @IBAction func profileImagePicker() {
        self.present(self.imagePicker, animated: true)
    }
    
    // MARK: - 함수
    func config() {
        addImageView.layer.cornerRadius = 25
        addImageView.layer.borderWidth = 0.5
    
        // 이미지 피커
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
        
        // 기본 데이터 설정
        guard let FN = UserDefaults.standard.value(forKey: UserDefaultKeyValue.firstName) as? String else {return}
        firstNameTextField.text = FN
        
        guard let LN = UserDefaults.standard.value(forKey: UserDefaultKeyValue.lastName) as? String else {return}
        lastNameTextField.text = LN
        
        guard let BD = UserDefaults.standard.value(forKey: UserDefaultKeyValue.birthDay) as? String else {return}
        birthDate.text = BD
        
        guard let EM = UserDefaults.standard.value(forKey: UserDefaultKeyValue.email) as? String else {return}
        email.text = EM
        
        guard let PN = UserDefaults.standard.value(forKey: UserDefaultKeyValue.phoneNum) as? String else {return}
        phoneNum.text = PN
        
        
    }
    // 세이브
    func save() {
        if isProfileImageEdited == true {
            UserDefaults.standard.set(UserInform.profileImage, forKey: UserDefaultKeyValue.profileImage)
        }
        
        UserDefaults.standard.set(email.text, forKey: UserDefaultKeyValue.email)
        UserDefaults.standard.set(lastNameTextField.text, forKey: UserDefaultKeyValue.lastName)
        UserDefaults.standard.set(firstNameTextField.text, forKey: UserDefaultKeyValue.firstName)
        
        if isPhoneNumEdited == true {
            UserDefaults.standard.set(phoneNum.text, forKey: UserDefaultKeyValue.phoneNum)
        }
        
        self.presentAlert(title: "저장되었습니다😃")
        
    }
    
    
    
}

// MARK: - UIImagePickerControllerDelegate
extension PersonalInformViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil // update 할 이미지
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        
        self.profileImageView.image = newImage // 받아온 이미지를 update
        let image = newImage?.pngData()
        UserInform.profileImage = image
        isProfileImageEdited = true
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
    }
}
// MARK: - UITextFieldDelegate
extension PersonalInformViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneNum {
            isPhoneNumEdited = true
        }
    }
}
