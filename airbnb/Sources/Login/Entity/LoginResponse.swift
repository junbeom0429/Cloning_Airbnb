//
//  LoginResponse.swift
//  airbnb
//
//  Created by JB on 2021/06/01.
//

struct LoginRequest: Encodable {
    var email: String
    var password: String
}

struct LoginResponse: Decodable {
        var isSuccess: Bool
        var code: Int
        var message: String
        var result: Jwt?
}

struct Jwt: Decodable {
    var jwt: String
}
