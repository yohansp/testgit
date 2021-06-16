//
//  EntranceViewController.swift
//  AstraPay
//
//  Created by yohanes saputra on 08/06/21.
//

import UIKit
import SwinjectStoryboard
//import Bond

class EntranceViewController: UIViewController {
    
    var modelView: EntranceModelView!
    var storyBoard = SwinjectStoryboard.create(name: "Authentication", bundle: nil, container: container)
    let cache = container.resolve(CacheAuth.self)!
    let popUpOtp = PopUpOTP()
    
    @IBOutlet weak var btnSubmit: AstraButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cache.test()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let cache = container.resolve(CacheAuth.self)
        cache?.clearForLogout()
        
        DispatchQueue.main.async {
            //self.popUpOtp.resetOTP()
            self.popUpOtp.delegate = self
            self.showPopUpBottomView(withView: self.popUpOtp, height: CGFloat(500))
            self.popUpOtp.setupView()
        }
    }
    
    @IBAction func onEnter(_ sender: Any) {
        // #non injection
//        let authStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
//        let loginController = authStoryboard.instantiateViewController(identifier: "phoneLoginViewController") as! PhoneLoginViewController
//        loginController.modalPresentationStyle = .fullScreen
//        self.present(loginController, animated: true, completion: nil)
        
        // #with injection
        let sb = SwinjectStoryboard.create(name: "Authentication", bundle: nil, container: container )
        let loginController = sb.instantiateViewController(withIdentifier: "phoneLoginViewController") as! PhoneLoginViewController
        loginController.modalTransitionStyle = .crossDissolve
        loginController.modalPresentationStyle = .fullScreen
//        self.dismiss(animated: true) {
            self.present(loginController, animated: true, completion: nil)
//        }
        
//        navigationController?.pushViewController(loginController, animated: true)
    }
}

extension EntranceViewController : PopUpOTPProtocol {
    func didPressSendOTP(otp: String) {
        print("---> didPressSendOTP")
    }
    
    func didPressResendButton() {
        print("---> didPressResendButton")
    }
}
