//
//  AuthRepository.swift
//  AstraPay
//
//  Created by yohanes saputra on 08/06/21.
//

import Foundation
import Alamofire

class AuthRepository {
    
    let baseUrlAuth = "\(baseUrl)/astrapay/fif"
    var cacheAuth: CacheAuth? = nil
    
    func constructHeader() -> HTTPHeaders {
        let header: HTTPHeaders = [
            "X-Application-Token": cacheAuth?.getLoginData()?.token ?? embedKey
        ]
        return header
    }
    
    func doCheckPhonenumber(phone:String, completion: @escaping(_:DataResponse<LoginResponse, AFError>) -> Void  ) -> DataRequest {
        let header = constructHeader()
        let url = "\(baseUrlAuth)/member/chekAccount/mobile"
        let param = ["account" : "\(phone)"]
        
        let request = AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
            //.validate(statusCode: 200..<300)
            .responseDecodable(of: LoginResponse.self) { response in
                debugPrint(response)
                completion(response)
        }
        return request
    }
    
    func doLogin(loginRequest: LoginRequest, completion: @escaping(_:DataResponse<LoginResponse, AFError>) -> Void) -> DataRequest {
        let header = constructHeader()
        let url = "\(baseUrlAuth)/v2/login/mobile"
        let param = [
            "account": loginRequest.account,
            "deviceId" : loginRequest.deviceId,
            "securityKey": loginRequest.securityKey,
            "issuer": loginRequest.issuer
        ]
        
        let request = AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: LoginResponse.self) { response in
                debugPrint(response)
                completion(response)
        }
        return request
    }
}
