//
//  InputPinView.swift
//  astrapay
//
//  Created by Guntur Budi on 03/08/20.
//  Copyright © 2020 Tirta Rivaldi. All rights reserved.
//

import UIKit


protocol InputPinViewProtocol : class {
    func didFinishInputPin(didFinish: Bool, pinField : String)
}

@IBDesignable
class InputPinView: UIView {

   static let identifier = "inputPinViewIdentifier"
    static let nibName = "InputPinView"
    var view: UIView!
    
    @IBOutlet weak var inputOne : LoginPinTextField!
    @IBOutlet weak var inputTwo : LoginPinTextField!
    @IBOutlet weak var inputThree : LoginPinTextField!
    @IBOutlet weak var inputFour : LoginPinTextField!
    @IBOutlet weak var inputFive : LoginPinTextField!
    @IBOutlet weak var inputSixth : LoginPinTextField!
    
     var arrayOfPin : [String] = ["","","","","",""]
    
    var delegate : InputPinViewProtocol?

    var conditionDelete = false
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         xibSetup(nibName: InputPinView.nibName)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
         xibSetup(nibName: InputPinView.nibName)
    }
    
    override func awakeFromNib() {
         xibSetup(nibName: InputPinView.nibName)
    }
    
    func setupView(){
        self.inputOne.setupView(txTag: 0)
        self.inputOne.textField.delegate = self
        self.inputOne.textField.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        
        
        self.inputTwo.setupView(txTag: 1)
        self.inputTwo.textField.delegate = self
        self.inputTwo.textField.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        self.inputTwo.textField.backspaceCalled = {
            print("backspaced 2")
            self.textfieldDeleteButtonAlgorithm(tag : 1)
        }
        
        self.inputThree.setupView(txTag: 2)
        self.inputThree.textField.delegate = self
        self.inputThree.textField.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        self.inputThree.textField.backspaceCalled = {
            self.textfieldDeleteButtonAlgorithm(tag : 2)
            print("backspaced 3")
        }
        
        self.inputFour.setupView(txTag: 3)
        self.inputFour.textField.delegate = self
        self.inputFour.textField.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        self.inputFour.textField.backspaceCalled = {
            print("backspaced 4")
            self.textfieldDeleteButtonAlgorithm(tag : 3)
        }
        
        self.inputFive.setupView(txTag: 4)
        self.inputFive.textField.delegate = self
        self.inputFive.textField.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        self.inputFive.textField.backspaceCalled = {
            print("backspaced 5")
            self.textfieldDeleteButtonAlgorithm(tag : 4)
        }
        
        self.inputSixth.setupView(txTag: 5)
        self.inputSixth.textField.delegate = self
        self.inputSixth.textField.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        self.inputSixth.textField.backspaceCalled = {
            print("backspaced 6")
            self.textfieldDeleteButtonAlgorithm(tag : 5)
            
        }
    }
    
    func textfieldSwitcher(tag : Int){
        switch tag {
        case 0 :
            inputOne.textField.becomeFirstResponder()
            break
        case 1 :
            inputTwo.textField.becomeFirstResponder()
            break
        case 2 :
            inputThree.textField.becomeFirstResponder()
            break
        case 3 :
            inputFour.textField.becomeFirstResponder()
            break
        case 4 :
            inputFive.textField.becomeFirstResponder()
            break
        case 5 :
            inputFive.textField.becomeFirstResponder()
            break
        default :
            break
        }
    }
    
}

extension InputPinView : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.tintColor = .clear
        let conditionStartFromEndField = !self.arrayOfPin.contains("")
        
        if conditionStartFromEndField {
            self.inputSixth.textField.becomeFirstResponder()
        }else if !conditionDelete{
            self.textFieldSwitcher()
        }
    }
    
    @objc func textfieldDidChange(_ textField: UITextField){
        print("textnya adalah : " + (textField.text ?? "none"))
        
       self.arrayOfPin[textField.tag] = textField.text ?? ""
       self.setTextFieldColor(tag: textField.tag)
        
        let conditionForward = textField.text != ""
        if conditionForward {
            textField.endEditing(true)
            self.conditionDelete = false
            self.textFieldSwitcher()
        }else {
            self.conditionDelete = true
            self.textfieldDeleteAlgorithm(tag: textField.tag)
        }
    }
    
    
    
    func textFieldSwitcher(){
            if arrayOfPin[0] == "" {
            self.inputOne.textField.becomeFirstResponder()
            return
        }
    
            if arrayOfPin[1] == "" {
            self.inputTwo.textField.becomeFirstResponder()
            return
        }
    
            if arrayOfPin[2] == "" {
            self.inputThree.textField.becomeFirstResponder()
            return
        }
    
            if arrayOfPin[3] == "" {
            self.inputFour.textField.becomeFirstResponder()
            return
        }
    
            if arrayOfPin[4] == "" {
            self.inputFive.textField.becomeFirstResponder()
            return
        }
    
            if arrayOfPin[5] == "" {
            self.inputSixth.textField.becomeFirstResponder()
            return
        }
    
        
    }
    
    func setTextFieldColor(tag : Int){
        switch tag {
        case 0:
            if arrayOfPin[tag] != "" {
                self.inputOne.viewFilledText()
            }else {
                self.inputOne.viewEmptyText()
            }
            break
        case 1:
             if arrayOfPin[tag] != "" {
                 self.inputTwo.viewFilledText()
             }else {
                 self.inputTwo.viewEmptyText()
             }
            break
        case 2:
             if arrayOfPin[tag] != "" {
                 self.inputThree.viewFilledText()
             }else {
                 self.inputThree.viewEmptyText()
             }
            break
        case 3:
             if arrayOfPin[tag] != "" {
                 self.inputFour.viewFilledText()
             }else {
                 self.inputFour.viewEmptyText()
             }
            break
        case 4:
             if arrayOfPin[tag] != "" {
                 self.inputFive.viewFilledText()
             }else {
                 self.inputFive.viewEmptyText()
             }
            break
        case 5:
             if arrayOfPin[tag] != "" {
                 self.inputSixth.viewFilledText()
             }else {
                 self.inputSixth.viewEmptyText()
             }
            break
        default:
            break
        }
        
    }
    
    func textfieldDeleteAlgorithm(tag : Int){
        switch tag {
        case 0:
            self.endEditing(true)
            break
        case 1:
            self.inputOne.textField.becomeFirstResponder()
            break
        case 2:
            self.inputTwo.textField.becomeFirstResponder()
            break
        case 3:
            self.inputThree.textField.becomeFirstResponder()
            break
        case 4:
            self.inputFour.textField.becomeFirstResponder()
            break
        case 5:
            self.inputFive.textField.becomeFirstResponder()
            break
        default:
            break
        }
    }
    
    func textfieldDeleteButtonAlgorithm(tag : Int){
        self.conditionDelete = true
        switch tag {
        case 0:
            self.endEditing(true)
            break
        case 1:
            self.arrayOfPin[tag-1] = ""
            self.inputOne.viewEmptyText()
            break
        case 2:
            self.arrayOfPin[tag-1] = ""
            self.inputTwo.viewEmptyText()
            break
        case 3:
            self.arrayOfPin[tag-1] = ""
            self.inputThree.viewEmptyText()
            break
        case 4:
            self.arrayOfPin[tag-1] = ""
            self.inputFour.viewEmptyText()
            break
        case 5:
            self.arrayOfPin[tag-1] = ""
            self.inputFive.viewEmptyText()
            break
        default:
            break
        }
        self.textFieldSwitcher()
    }

    
}


