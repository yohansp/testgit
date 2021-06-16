//
//  PinLoginViewController.swift
//  AstraPay
//
//  Created by yohanes saputra on 08/06/21.
//

import UIKit
import RxSwift

class PinLoginViewController: UIViewController {

    var model : PinLoginViewModel!
    let cache = container.resolve(CacheAuth.self)!
    @IBOutlet weak var pinView: LKPINView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // init ui
        LKPINView.setupBaseBackground()
        pinView.tag = 11
        pinView.addTarget(self, action: #selector(onPINEditing(_:)), for: .editingDidEnd)
        pinView.addTarget(self, action: #selector(onPINChanged(_:)), for: .valueChanged)
        pinView.becomeFirstResponder()
    }
    
    @IBAction func onPINEditing(_ sender: LKPINView) {
        if sender.tag == 11 {
            // start request login
            requestLogin()
        } else {
            sender.resignFirstResponder()
            pinView.becomeFirstResponder()
        }
    }
    
    @IBAction func onPINChanged(_ sender : LKPINView){
        if sender.tag == 11 {
        } else {
            sender.resignFirstResponder()
            pinView.becomeFirstResponder()
        }
    }

    func requestLogin() {
        showWait()
        model.doLogin(phoneNumber: "0\(cache.getPhone()!)", pin: pinView.pinString)
            .subscribe(
                onNext:{ data in
                    self.hideWait()
                },
                onError: { error in
                }
            )
    }
}
