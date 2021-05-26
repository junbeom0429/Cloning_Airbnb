//
//  Regex.swift
//  airbnb
//
//  Created by JB on 2021/05/26.
//
import UIKit
open class Regex {
    static let shared = Regex()
    // 전화번호
    func isPhone(candidate: String) -> Bool {
            let regex = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
            return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: candidate)
    }
    //이메일
    func isEmail(candidate: String) -> Bool{
            let regex = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
            return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: candidate)
    }
}
