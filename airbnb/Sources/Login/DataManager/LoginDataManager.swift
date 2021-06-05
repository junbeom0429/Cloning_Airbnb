//
//  LoginDataManager.swift
//  airbnb
//
//  Created by JB on 2021/06/01.
//

import Alamofire
import UIKit

open class LoginDataManager {
    func loginWithEmail(_ parameters: LoginRequest, delegate: LoginVC, completion: @escaping (Int) -> ()) {
        AF.request(Constant.loginMainURL, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil).validate().responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    delegate.successLogin(result)
                } else {
                    //delegate.successRequest(response.code)
                    
                    delegate.code = response.code
                    print("code transfer comple CODE: \(delegate.code)")
                    completion(response.code)
                }
            case .failure(_):
                print("서버연결 실패 : \(response)")
                delegate.failureResquest()
            }
            
        }
        
        
    }
    
    func doit() {
        print("getIn doit()")
        let ss = UIStoryboard(name: "Login", bundle: nil)
        let ssd = ss.instantiateViewController(identifier: "LoginVC")
        
        ssd.performSegue(withIdentifier: "goToRegi", sender: nil)
    }
}
