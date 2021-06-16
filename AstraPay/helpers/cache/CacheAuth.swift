//
//  CacheAuth.swift
//  AstraPay
//
//  Created by yohanes saputra on 10/06/21.
//

import Foundation

class CacheAuth : NSObject {

    enum KeyName : CaseIterable {
        case LOGIN_DATA
        case SECURE_KEY
        case MOBILE
    }
    
    func saveLoginData(loginData: LoginResponse) {
        do {
            let jsonData = try JSONEncoder().encode(loginData)
            let json = String(data: jsonData, encoding: .utf8)
            UserDefaults.standard.setValue(json, forKey: "\(KeyName.LOGIN_DATA)")
        } catch {
        }
    }
    
    func getLoginData() -> LoginResponse? {
        do {
            if let json = UserDefaults.standard.string(forKey: "\(KeyName.LOGIN_DATA)") {
                return try JSONDecoder().decode(LoginResponse.self, from: json.data(using: .utf16)! )
            }
            return nil
        } catch {
            return nil
        }
    }
    
    func savePhone(phone: String) {
        UserDefaults.standard.setValue(phone, forKey: "\(KeyName.MOBILE)" )
    }
    
    func getPhone() -> String? {
        return UserDefaults.standard.string(forKey: "\(KeyName.MOBILE)")
    }
    
    func saveSecureKey(secureKey: String) {
        UserDefaults.standard.setValue(secureKey, forKey: "\(KeyName.SECURE_KEY)")
    }
    
    func getSecureKey() -> String? {
        return UserDefaults.standard.string(forKey: "\(KeyName.SECURE_KEY)")
    }
    
    func clearForLogout() {
        for key in KeyName.allCases {
            UserDefaults.standard.removeObject(forKey: "\(key)")
        }
    }
    
    func test() {
        for key in KeyName.allCases {
            print("---> keyName: \(key) --> \(UserDefaults.standard.string(forKey: "\(key)" ))")
        }
    }
}
