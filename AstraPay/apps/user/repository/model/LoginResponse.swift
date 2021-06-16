//
//  LoginResponse.swift
//  AstraPay
//
//  Created by yohanes saputra on 08/06/21.
//

import Foundation

struct LoginResponse : Codable {
    var failure: Bool?
    var account: String?
    var isAccountExist: Bool?
    var token: String?
    var accessToken: String?
    var refreshToken: String?
    var astrakuId: String?
    var membershipId: String?
    var updateAt: String?
    var reqCode: String?
}
