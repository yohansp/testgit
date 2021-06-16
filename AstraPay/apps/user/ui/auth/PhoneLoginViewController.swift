//
//  PhoneLoginViewController.swift
//  AstraPay
//
//  Created by yohanes saputra on 08/06/21.
//

import Foundation
import UIKit
import SwinjectStoryboard

class PhoneLoginViewController : UIViewController {
    
    var model : PhoneLoginViewModel!
    var phoneNumber: String = ""
    let cache = container.resolve(CacheAuth.self)!

    @IBOutlet weak var inputPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputPhone.attributedPlaceholder = NSAttributedString(string: "No Handphone", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    @IBAction func onLogin(_ sender: Any) {
        self.showWait()
        phoneNumber = inputPhone.text!
        model.reqCheckMobile(phone: phoneNumber).subscribe(
            onNext: { data in
                self.hideWait()
                self.cache.savePhone(phone: self.phoneNumber)
                self.dismiss(animated: true) {
                    self.showPinLogin()
                }   
            },
            onError: { error in
                self.hideWait()
            }
        )
        
        // rxcocoa
    }
    
    func showPinLogin() {
        let sb = SwinjectStoryboard.create(name: "Authentication", bundle: nil, container: container )
        let pinController = sb.instantiateViewController(withIdentifier: "pinLoginViewController") as! PinLoginViewController
        pinController.modalPresentationStyle = .fullScreen
        self.present(pinController, animated: true, completion: nil)
//        navigationController?.pushViewController(pinController, animated: true)
    }
}
