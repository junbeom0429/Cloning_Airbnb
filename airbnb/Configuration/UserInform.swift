//
//  UserInform.swift
//  airbnb
//
//  Created by JB on 2021/05/25.
//
import UIKit

struct UserInform {
    static var country: String = "대한민국"
    static var countryNum: Int = 82
    static var firstName: String = ""
    static var lastName: String = ""
    static var fullName: String = makeFullname()
    static var phoneNum: Int = Int()
    static var email: String = ""
    static var isLogin: Bool = false
    static var marketingAgree: Bool = true
    static var password: String = ""
    static var birthDay: String = ""
    static var profileImage: Data? = Data()
}
struct UserDefaultKeyValue {
    static var country = "country"
    static var countryNum = "countryNum"
    static var firstName = "firstName"
    static var lastName = "lastName"
    static var fullName: String = makeFullname()
    static var phoneNum = "phoneNum"
    static var email = "email"
    static var isLogin = "isLogin"
    static var marketingAgree = "marketingAgree"
    static var password = "password"
    static var birthDay = "birthDay"
    static var profileImage = "profileImage"
}

func makeFullname() -> String {
    if UserInform.countryNum == 82 {
        return "\(UserInform.lastName)\(UserInform.firstName)"
    } else {
        return "\(UserInform.firstName) \(UserInform.lastName)"
    }
}

