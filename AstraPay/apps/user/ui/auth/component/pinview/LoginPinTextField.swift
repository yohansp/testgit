//
//  PinTextField.swift
//  astrapay
//
//  Created by Guntur Budi on 03/08/20.
//  Copyright © 2020 Tirta Rivaldi. All rights reserved.
//

import UIKit

@IBDesignable
class LoginPinTextField: UIView {
    
    @IBOutlet weak var viewPlaceholder : UIView!
    @IBOutlet weak var textField : InputLoginTextField!

    static let identifier = "loginPinTextFieldIdentifier"
    static let nibName = "LoginPinTextField"
    var view: UIView!

    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    func setupView(txTag : Int){
        DispatchQueue.main.async {
            self.textField.tag = txTag
            self.viewPlaceholder.setNeedsLayout()
            self.viewPlaceholder.layer.cornerRadius = self.viewPlaceholder.frame.width/2
            self.textField.layer.cornerRadius = self.viewPlaceholder.frame.width/2
            self.textField.backgroundColor = .clear
            self.textField.textColor = .clear
            self.viewEmptyText()
        }
    }
    
    func viewEmptyText(){
        
        self.viewPlaceholder.layer.borderColor = Colors.baseColor.cgColor
        self.viewPlaceholder.backgroundColor = .red
    }
    
    func viewFilledText(){
        self.backgroundColor = Colors.baseColor
        self.viewPlaceholder.layer.borderColor = Colors.baseColor.cgColor
        self.viewPlaceholder.backgroundColor = Colors.baseColor
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(nibName: LoginPinTextField.nibName)
    }


    required init?(coder: NSCoder) {
        super.init(coder: coder)
         xibSetup(nibName: LoginPinTextField.nibName)
    }

    override func awakeFromNib() {
         xibSetup(nibName: LoginPinTextField.nibName)
    }


}
