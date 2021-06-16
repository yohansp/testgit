//
//  PopUpOTP.swift
//  astrapay
//
//  Created by Guntur Budi on 14/08/20.
//  Copyright © 2020 Tirta Rivaldi. All rights reserved.
//

import UIKit


protocol PopUpOTPProtocol : class {
    func didPressSendOTP(otp : String)
    func didPressResendButton()
}

class PopUpOTP: UIView {

    static let identifier = "popUpOTPIdentifier"
    static let nibName = "PopUpOTP"
    
    static let titleButton = "Submit"
    
    @IBOutlet weak var constraintResendOTPCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var txFieldOne: InputLoginTextField!
    @IBOutlet weak var txFieldTwo: InputLoginTextField!
    @IBOutlet weak var txFieldThree: InputLoginTextField!
    @IBOutlet weak var txFieldFour: InputLoginTextField!
    @IBOutlet weak var txFieldFive: InputLoginTextField!
    @IBOutlet weak var txFieldSix: InputLoginTextField!
    
    @IBOutlet weak var coreButton: APButtonAtom!
    @IBOutlet weak var btnResendOTP: UIButton!
    
    @IBOutlet weak var lblWarning: UILabelInterSemiBold!
    @IBOutlet weak var lblTimer: UILabelInterSemiBold!
    
    let textFieldFont : UIFont = UIFont.systemFont(ofSize: 12)
    
    @IBOutlet weak var btnTest: UIButton!
    
    var fieldCode: String {
        if let text1 = self.txFieldOne.text,
            let text2 = self.txFieldTwo.text,
            let text3 = self.txFieldThree.text,
            let text4 = self.txFieldFour.text,
            let text5 = self.txFieldFive.text,
            let text6 = self.txFieldSix.text {
            if !text1.isEmpty && !text2.isEmpty && !text3.isEmpty && !text4.isEmpty && !text5.isEmpty && !text6.isEmpty {
                return "\(text1)\(text2)\(text3)\(text4)\(text5)\(text6)"
            }
        }
        return "\(self.txFieldOne.text!)\(self.txFieldTwo.text!)\(self.txFieldThree.text!)\(self.txFieldFour.text!)\(self.txFieldFive.text!)\(self.txFieldSix.text!)"
    }
    
    var arrOfPin : [String] = []
    
    static let popUpHeight : CGFloat = 350
    let cornerRadi : CGFloat = 5
    let borderNormalColor : UIColor = UIColor(string: "#cccccc")
    let borderWarningColor : UIColor = UIColor.red
    
    var seconds = 30
    var timer = Timer()
    let maxSendOTP : Int = 3
    var currentSendOTP: Int = 1
    var delegate : PopUpOTPProtocol?
    var arrayOfOTP : [String] = ["","","","","",""]
    
    var isConditionDelete = false
    let constResendOTPXWithTimer : CGFloat = -18
    let constResendOTPXWithoutTimer : CGFloat = 0
    
//    func setupAction(){
//        self.coreButton.coreButton.addTapGestureRecognizer(action: {
//            self.delegate?.didPressSendOTP(otp: self.fieldCode)
//        })
////        self.btnResendOTP.addTapGestureRecognizer(action: {
////            self.delegate?.didPressResendButton()
////            self.currentSendOTP += 1
////            self.seconds = 30
////            self.disableButtonResend()
////            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(PopUpOTP.updateTimer)), userInfo: nil, repeats: true)
////        })
//    }
    
    @objc func onResendOtp(sender: UIButton) {
//        self.delegate?.didPressResendButton()
//        self.currentSendOTP += 1
//        self.seconds = 30
//        self.disableButtonResend()
//        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(PopUpOTP.updateTimer)), userInfo: nil, repeats: true)
        
        print("------------> testing on resend OTP")
    }
    
    override class func awakeFromNib() {
    }
    
    func setupView(){
        DispatchQueue.main.async(execute: {
            self.containerView.roundedTopMessage(isFullScreen: true)
        })
            
        self.setupTextfield()
        
        //self.setupAction()
//        self.coreButton.coreButton.addTapGestureRecognizer(action: {
//            self.delegate?.didPressSendOTP(otp: self.fieldCode)
//        })
        
        self.btnTest.addTarget(self, action: #selector(self.onResendOtp(sender:)), for: .touchUpInside)
        
        //self.coreButton.coreButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onResendOtp(sender:))))
        self.enableButtonSend()
        self.coreButton.coreButton.isEnabled = true
        self.coreButton.coreButton.setTitle("Submit", for: .normal)
        self.coreButton.coreButton.addTarget(self, action: #selector(self.onResendOtp(sender:)), for: .touchUpInside)
        
        
        //self.coreButton.coreButton.addTarget(self, action: "onResendOtp", for: .touchUpInside)
        //self.btnResendOTP.addTarget(self, action: #selector(onResendOtp), for: .touchDown)
    
        self.txFieldOne.font = self.textFieldFont
        self.txFieldOne.layer.cornerRadius = self.cornerRadi
        self.txFieldOne.delegate = self
        self.txFieldOne.tag = 1
        self.txFieldOne.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        self.txFieldOne.backspaceCalled = {
        }
        
        self.txFieldTwo.font = self.textFieldFont
        self.txFieldTwo.layer.cornerRadius = self.cornerRadi
        self.txFieldTwo.delegate = self
        self.txFieldTwo.tag = 2
        self.txFieldTwo.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        self.txFieldTwo.backspaceCalled = {
            if self.txFieldTwo.text! == "" {
                self.hideWarning()
                self.isConditionDelete = true
                self.txFieldOne.becomeFirstResponder()
            }
        }
        
        self.txFieldThree.font = self.textFieldFont
        self.txFieldThree.layer.cornerRadius = self.cornerRadi
        self.txFieldThree.delegate = self
        self.txFieldThree.tag = 3
        self.txFieldThree.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        self.txFieldThree.backspaceCalled = {
            if self.txFieldThree.text! == "" {
                self.hideWarning()
                self.isConditionDelete = true
                self.txFieldTwo.becomeFirstResponder()
            }
        }
        
        self.txFieldFour.font = self.textFieldFont
        self.txFieldFour.layer.cornerRadius = self.cornerRadi
        self.txFieldFour.delegate = self
        self.txFieldFour.tag = 4
        self.txFieldFour.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        self.txFieldFour.backspaceCalled = {
                if self.txFieldFour.text! == "" {
                    self.hideWarning()
                    self.isConditionDelete = true
                    self.txFieldThree.becomeFirstResponder()
                }
        }
        
        self.txFieldFive.font = self.textFieldFont
        self.txFieldFive.layer.cornerRadius = self.cornerRadi
        self.txFieldFive.delegate = self
        self.txFieldFive.tag = 5
        self.txFieldFive.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        self.txFieldFive.backspaceCalled = {
            if self.txFieldFive.text! == "" {
                self.hideWarning()
                self.isConditionDelete = true
                self.txFieldFour.becomeFirstResponder()
            }
        }
        
        self.txFieldSix.font = self.textFieldFont
        self.txFieldSix.layer.cornerRadius = self.cornerRadi
        self.txFieldSix.delegate = self
        self.txFieldSix.tag = 6
        self.txFieldSix.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        self.txFieldSix.backspaceCalled = {
            if self.txFieldSix.text! == "" {
                self.hideWarning()
                self.isConditionDelete = true
                self.txFieldFive.becomeFirstResponder()
            }
        }
        
        self.txFieldOne.becomeFirstResponder()
        self.coreButton.layer.cornerRadius = 15
        //self.coreButton.isUserInteractionEnabled = false
        //self.coreButton.setAtomic(type: .disabled, title: PopUpOTP.titleButton, messageError: "")

        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
           if self.seconds == 0 {
                self.timer.invalidate()
                self.btnResendOTP.setTitle("Kirim Kembali OTP - (\(self.currentSendOTP)/3)", for: .normal)
                self.lblTimer.isHidden = true
            if self.currentSendOTP < self.maxSendOTP {
                    self.enableButtonResend()
                }else {
                     self.disableButtonResend()
                }
           } else {
                self.seconds -= 1
                self.lblTimer.isHidden = false
                self.btnResendOTP.setTitle("Kirim Kembali OTP - (\(self.currentSendOTP)/3)", for: .normal)
                self.lblTimer.text = "(\(timeString(time: TimeInterval(seconds))))"
                self.disableButtonResend()
           }
    }
    
    func disableButtonResend (){
        self.constraintResendOTPCenterX.constant = self.constResendOTPXWithTimer
        self.btnResendOTP.isUserInteractionEnabled = false
        //self.btnResendOTP.titleLabel?.font = UIFont.font(size: 12, fontType: .interBold)
        self.btnResendOTP.setTitleColor(UIColor(string: "#b2b2b2"), for: .normal)
    }
    
    func enableButtonResend(){
        self.constraintResendOTPCenterX.constant = self.constResendOTPXWithoutTimer
        self.btnResendOTP.isUserInteractionEnabled = true
        //self.btnResendOTP.titleLabel?.font = UIFont.font(size: 12, fontType: .interBold)
        //self.btnResendOTP.setTitleColor(BaseColor.Properties.baseColor, for: .normal)
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func setupTextfield(){
        self.txFieldOne.borderStyle = .none
        self.txFieldTwo.borderStyle = .none
        self.txFieldThree.borderStyle = .none
        self.txFieldFour.borderStyle = .none
        self.txFieldFive.borderStyle = .none
        self.txFieldSix.borderStyle = .none
        self.hideWarning()
        self.txFieldOne.layer.borderWidth = 1
        self.txFieldTwo.layer.borderWidth = 1
        self.txFieldThree.layer.borderWidth = 1
        self.txFieldFour.layer.borderWidth = 1
        self.txFieldFive.layer.borderWidth = 1
        self.txFieldSix.layer.borderWidth = 1
    }
    
    func showWarning(){
        self.lblWarning.isHidden = false
        self.txFieldOne.layer.borderColor = self.borderWarningColor.cgColor
        self.txFieldTwo.layer.borderColor = self.borderWarningColor.cgColor
        self.txFieldThree.layer.borderColor = self.borderWarningColor.cgColor
        self.txFieldFour.layer.borderColor = self.borderWarningColor.cgColor
        self.txFieldFive.layer.borderColor = self.borderWarningColor.cgColor
        self.txFieldSix.layer.borderColor = self.borderWarningColor.cgColor
    }
    
    func hideWarning(){
        self.lblWarning.isHidden = true
        self.txFieldOne.layer.borderColor = self.borderNormalColor.cgColor
        self.txFieldTwo.layer.borderColor = self.borderNormalColor.cgColor
        self.txFieldThree.layer.borderColor = self.borderNormalColor.cgColor
        self.txFieldFour.layer.borderColor = self.borderNormalColor.cgColor
        self.txFieldFive.layer.borderColor = self.borderNormalColor.cgColor
        self.txFieldSix.layer.borderColor = self.borderNormalColor.cgColor
    }
    
    func resetOTP(){
        self.txFieldOne.text = ""
        self.txFieldTwo.text = ""
        self.txFieldThree.text = ""
        self.txFieldFour.text = ""
        self.txFieldFive.text = ""
        self.txFieldSix.text = ""
        self.hideWarning()
        self.disableButtonSend()
    }
    
    func enableButtonSend(){
        self.coreButton.isUserInteractionEnabled = true
        //self.coreButton.setAtomic(type: .filled, title: PopUpOTP.titleButton, messageError: "")
    }
    
    func disableButtonSend(){
        self.coreButton.isUserInteractionEnabled = false
        //self.coreButton.setAtomic(type: .disabled, title: PopUpOTP.titleButton, messageError: "")
    }
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(nibName: PopUpOTP.nibName)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup(nibName: PopUpOTP.nibName)
    }

    override func awakeFromNib() {
        xibSetup(nibName: PopUpOTP.nibName)
    }
}

extension PopUpOTP : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.count >= 1 && string != ""{
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.tintColor = .clear
        if self.fieldCode.count == 6 {
            DispatchQueue.main.async {
                self.txFieldSix.becomeFirstResponder()
            }

        } else {
            if !self.isConditionDelete{
                if self.txFieldOne.text == "" {
                    self.txFieldOne.becomeFirstResponder()
                }else if self.txFieldTwo.text == "" {
                    self.txFieldTwo.becomeFirstResponder()
                }else if self.txFieldThree.text == "" {
                    self.txFieldThree.becomeFirstResponder()
                }else if self.txFieldFour.text == "" {
                    self.txFieldFour.becomeFirstResponder()
                }else if self.txFieldFive.text == "" {
                    self.txFieldFive.becomeFirstResponder()
                }else if self.txFieldSix.text == "" {
                    self.txFieldSix.becomeFirstResponder()
                }
            }else if self.txFieldOne.text == "" {
                self.txFieldOne.becomeFirstResponder()
            }
            
        }
    }
    
    @objc func textFieldChanged(_ textField: UITextField){
        let conditionMax = textField.text!.count == 1
        let conditionNotPressBack = textField.text! != ""
        
       if conditionMax && conditionNotPressBack {
            self.isConditionDelete = false
            self.hideWarning()
            self.textFieldSwitcher(tag: textField.tag)
        }
        
        let conditionOTPFilled = self.fieldCode.count == 6
        if conditionOTPFilled {
            //self.enableButtonSend()
        }else {
            //self.disableButtonSend()
        }
        
    }
    
    func textFieldSwitcher(tag : Int){
        switch tag {
        case 1:
            self.txFieldTwo.becomeFirstResponder()
            break
        case 2:
            self.txFieldThree.becomeFirstResponder()
           break
        case 3:
            self.txFieldFour.becomeFirstResponder()
           break
        case 4:
            self.txFieldFive.becomeFirstResponder()
           break
        case 5:
            self.txFieldSix.becomeFirstResponder()
           break
        case 6:
            self.endEditing(true)
            self.enableButtonSend()
           break
        default:
            break
        }
    }
    
    
}
