//
//  AppDelegate.swift
//  AstraPay
//
//  Created by yohanes saputra on 08/06/21.
//

import UIKit
import Swinject
import SwinjectStoryboard

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerDependecies()
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func registerDependecies()  {
        // start register injection
        container.register(CacheAuth.self) { resolver in
            CacheAuth()
        }.inObjectScope(.container)
        
        container.register(AuthRepository.self) { resolver in
            let auth = AuthRepository()
            auth.cacheAuth = resolver.resolve(CacheAuth.self)
            return auth
        }.inObjectScope(.container)
        
        diRegisterEntrance()
        diRegisterAuth()
    }
    
    func diRegisterEntrance() {
        container.register(EntranceModelView.self) { resolver in
            let mv = EntranceModelView()
            mv.authRepository = resolver.resolve(AuthRepository.self)!
            return mv
        }
        
        container.register(EntranceViewController.self) { resolver in
            let v = EntranceViewController()
            v.modelView = resolver.resolve(EntranceModelView.self)
            return v
        }
    }
    
    func diRegisterAuth() {
        container.register(PhoneLoginViewModel.self) { resolver in
            let mv = PhoneLoginViewModel()
            mv.authRepository = resolver.resolve(AuthRepository.self)
            return mv
        }
        
        container.register(PinLoginViewModel.self) { resolver in
            let m = PinLoginViewModel()
            m.authRepository = resolver.resolve(AuthRepository.self)
            return m
        }
        
        container.storyboardInitCompleted(PhoneLoginViewController.self){ r,c in
            c.model = r.resolve(PhoneLoginViewModel.self)
        }
        
        container.storyboardInitCompleted(PinLoginViewController.self){ r,c in
            c.model = r.resolve(PinLoginViewModel.self)
        }
    }
}

