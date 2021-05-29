//
//  UserInform.swift
//  airbnb
//
//  Created by JB on 2021/05/25.
//


struct UserInform {
    static var country: String = "대한민국"
    static var countryNum: Int = 82
    static var firstName: String = ""
    static var lastName: String = ""
    static var fullName: String = makeFullname()
    static var phoneNum: Int = Int()
    static var email: String = String()
    static var isLogin: Bool = false
    static var marketingAgree: Bool = true
    static var password: String = ""
    static var birthDay: String = ""
    
}
func makeFullname() -> String {
    if UserInform.countryNum == 82 {
        return "\(UserInform.lastName)\(UserInform.firstName)"
    } else {
        return "\(UserInform.firstName) \(UserInform.lastName)"
    }
}
//
