//
//  LoginDataManager.swift
//  airbnb
//
//  Created by JB on 2021/06/01.
//

import Alamofire

open class LoginDataManager {
    func loginWithEmail(_ parameters: LoginRequest, viewController: LoginVC) {
        AF.request(Constant.loginMainURL, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil).validate().responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    viewController.successLogin(result)
                } else {
                    viewController.successResquest(response.code)
                    switch response.code {
                    case 2505:
                        print("이메일존재")
                    case 3100:
                        print("이메일없음 회원가입필요")
                    case 2503:
                        print("")
                    default:
                        print("입력값 오류")
                    }
                }
            case .failure(_):
                print("서버연결 실패 : \(response)")
                viewController.failureResquest()
            }
        }
    }
}
