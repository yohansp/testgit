//
//  LKPinView.swift
//  astrapay
//
//  Created by Guntur Budi on 11/08/20.
//  Copyright © 2020 Tirta Rivaldi. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class LKPINView: UIControl, UIKeyInput {
    
    //config
    static var bgBorderColor : UIColor = Colors.pinPlaceholderColor
    static var bgColorPlaceholder : UIColor = Colors.baseColor
    static var bgColorFilled : UIColor = Colors.pinPlaceholderColor
    static let borderWidth : CGFloat = 1.0
    
    static func setupWhiteBackground(){
        LKPINView.bgBorderColor = Colors.baseColor
        LKPINView.bgColorFilled = Colors.baseColor
        LKPINView.bgColorPlaceholder = .white
    }
    
    static func setupBaseBackground(){
        LKPINView.bgBorderColor = Colors.pinPlaceholderColor
        LKPINView.bgColorPlaceholder = Colors.baseColor
        LKPINView.bgColorFilled = Colors.pinPlaceholderColor
    }
    
    static func setupBlackColor(){
        LKPINView.bgBorderColor = .black
        LKPINView.bgColorPlaceholder = .white
        LKPINView.bgColorFilled = .black
    }
    
    @IBInspectable var numberOfDigits: Int = 6 {
        didSet{
            self.setupViews()
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var spacing: CGFloat = 12 {
        didSet{
            pinsStack.spacing = spacing
            self.setupViews()
            self.layoutIfNeeded()
        }
    }
    
    //MARK: UIKeyInput Protocol Methods
    var hasText: Bool {
        
        return nextTag > 1 ? true : false
    }
    
    var isPopUP : Bool = false
    
    var pinString: String = ""
    
    func insertText(_ text: String) {
        
        if nextTag < (numberOfDigits + 1) {
            (viewWithTag(nextTag)! as! PINView).key = text
            nextTag += 1
            
            if nextTag == (numberOfDigits + 1) {
                //        resignFirstResponder()
                self.pinString = ""
                for index in 1..<nextTag {
                    self.pinString += (viewWithTag(index)! as! PINView).key
                }
                self.sendActions(for: .editingDidEnd)
            }

            self.sendActions(for: .valueChanged)
        }
        
    }
    
    func deleteBackward() {
        if nextTag > 1 {
            nextTag -= 1
            (viewWithTag(nextTag)! as! PINView).key = ""
        }
    }
    
    func clear() {
        while nextTag > 1 {
            deleteBackward()
        }
    }
    
    // MARK: UITextInputTraits
    
    var keyboardType: UIKeyboardType {
        get{
            return .numberPad
        }
        set{
            
        }
    }
    
    //MARK: LKPINView Properties and Methods
    private var nextTag = 1
    private lazy var pinsStack: UIStackView = {
        
        let sv = UIStackView.init()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fill
        sv.spacing = spacing
        
        return sv
    }()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViewsToTheControl()
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSubViewsToTheControl()
        setupViews()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        addSubViewsToTheControl()
        setupViews()
    }
    
    private func addSubViewsToTheControl() {
        self.backgroundColor = .clear
        addSubview(pinsStack)
    }
    
    private func setupViews() {
        
        for pinView in pinsStack.arrangedSubviews {
            pinView.removeFromSuperview()
        }
        
        for cons in constraints {
            if cons.firstAttribute == .width {
                cons.isActive = false
            }
        }
        layoutIfNeeded()
        
        for tag in 1...numberOfDigits {
            let pin = PINView.init(frame: .zero)
            pin.tag = tag
            pin.translatesAutoresizingMaskIntoConstraints = false
            pinsStack.addArrangedSubview(pin)
        }

        if self.isPopUP {
            addConstraints([
                pinsStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                pinsStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                pinsStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15, constant: 0),
                pinsStack.widthAnchor.constraint(equalTo: pinsStack.heightAnchor, multiplier: CGFloat(numberOfDigits), constant: (CGFloat(numberOfDigits - 1) * spacing)),
            ])
        }else {
        
            addConstraints([
                pinsStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                pinsStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                pinsStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35, constant: 0),
                pinsStack.widthAnchor.constraint(equalTo: pinsStack.heightAnchor, multiplier: CGFloat(numberOfDigits), constant: (CGFloat(numberOfDigits - 1) * spacing)),
            ])
        }
        
        for pinnn in pinsStack.arrangedSubviews {
            
            guard let pin = pinnn as? PINView else {return}
            
            pinsStack.addConstraints([
                
                pin.heightAnchor.constraint(equalTo: pinsStack.heightAnchor, multiplier: 1),
                pin.widthAnchor.constraint(equalTo: pin.heightAnchor, constant: 0)
                
                ])
            
        }
        
    }
    
    //MARK: Helper class to generate pin views
    private class PINView: UIView {
        
        var key: String = "" {
            didSet{
                setupViews()
            }
        }
        
        var hasText: Bool {
            return key != ""
        }
        
        override var bounds: CGRect {
            didSet{
                setupViews()
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupViews() {
            
            let neededRadius = min(self.bounds.width, self.bounds.height)
            self.layer.cornerRadius = neededRadius / 2
            self.layer.masksToBounds = true
            self.layer.borderWidth = LKPINView.borderWidth
            
            if hasText {
                self.layer.borderColor = bgBorderColor.cgColor
                self.backgroundColor = bgColorFilled
            } else {
                self.layer.borderColor = bgBorderColor.cgColor
                self.backgroundColor = bgColorPlaceholder
            }
            
        }
        
    }
    
}
