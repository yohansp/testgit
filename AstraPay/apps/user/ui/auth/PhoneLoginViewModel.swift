//
//  PhoneLoginViewModel.swift
//  AstraPay
//
//  Created by yohanes saputra on 09/06/21.
//

import Foundation
import RxSwift
//import Alamofire

class PhoneLoginViewModel: NSObject {
    
    var authRepository: AuthRepository!
    
    override init() {
    }
    
    func reqCheckMobile(phone: String) -> Observable<LoginResponse> {
        let paramPhone = "0\(phone)"
        return .create { observer in
            let request = self.authRepository.doCheckPhonenumber(phone: paramPhone) { response in
                switch response.result {
                case .failure(let error) :
                    observer.onError(error)
                case .success(let data):
                    observer.onNext(data)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
