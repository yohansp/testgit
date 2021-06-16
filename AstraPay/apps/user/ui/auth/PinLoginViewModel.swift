//
//  PinLoginViewModel.swift
//  AstraPay
//
//  Created by yohanes saputra on 09/06/21.
//

import Foundation
import RxSwift

class PinLoginViewModel: NSObject {
    
    var authRepository : AuthRepository!
    var cache = container.resolve(CacheAuth.self)
    
    override init() {
    }
    
    func doLogin(phoneNumber: String, pin: String) -> Observable<LoginResponse>{
        return .create { observer in
            
            if let secKey = SHA1.hexString(from: "\(phoneNumber)\(pin)") {
                let data = LoginRequest(account: phoneNumber,
                                        deviceId: UIDevice.current.identifierForVendor!.uuidString,
                                        issuer: "850500",
                                        securityKey: secKey )
                let request = self.authRepository.doLogin(loginRequest: data) { response in
                    switch response.result {
                    case .failure(let error) :
                        observer.onError(error)
                    case .success(let data) :
                        self.cache?.saveLoginData(loginData: data)
                        self.cache?.saveSecureKey(secureKey: secKey)
                        observer.onNext(data)
                    }
                }
                return Disposables.create {
                    request.cancel()
                }
            }
            return Disposables.create{}
        }
    }
}
