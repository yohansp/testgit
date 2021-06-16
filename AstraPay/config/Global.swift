//
//  Global.swift
//  AstraPay
//
//  Created by yohanes saputra on 09/06/21.
//

import Foundation
import Swinject

var container: Container = Container()
var baseUrl = Bundle.main.infoDictionary?["BaseUrl"] as! String
var embedKey = Bundle.main.infoDictionary?["EmbedKey"] as! String
