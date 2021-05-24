//
//  Constant.swift
//  airbnb
//
//  Created by JB on 2021/05/22.
//

import Alamofire

struct Constant {
    static let googleOAuth = "186497991722-ts2ubj7gaf851vfv8b3vcnqjq0g5p5mf.apps.googleusercontent.com"
    
    static let countryList: [String:Int] = [
        "가나": 82,
        "가봉": 82,
        "가이아나": 82,
        "감비아": 82,
        "건지": 82,
        "괌": 82,
        "과들루프": 82,
        "과테말라": 82,
        "그레나다": 82,
        "그리스": 82,
        "그린란드": 82,
        "기니": 82,
        "기니비사우": 82,
        "나미비아": 82,
        "나우루": 82,
        "나이지리아": 82,
        "남수단": 82,
        "남아프리카": 82,
        "네덜란드": 82,
        "대한민국": 82
    ]
    
}

var country: [CountryNumber] = []


struct CountryNumber: Codable {
    var name: String
    var num: Int
}

