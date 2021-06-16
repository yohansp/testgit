//
//  APButtonAtom.swift
//  astrapay
//
//  Created by Nur Irfan Pangestu on 01/04/20.
//  Copyright © 2020 Tirta Rivaldi. All rights reserved.
//  

import UIKit

@IBDesignable
class APButtonAtom: UIView {
    
    @IBOutlet weak var coreButton: UIButton!
    @IBOutlet weak var coreMessageError: UILabelInterRegular!
    
    var contentView:UIView?
    @IBInspectable var nibName:String? = "APButtonAtom"
    
    enum Style {
        case filled
        case nude
        case nudeWhite
        case nudeNoBorder
        case disabled
        case clear
        case hightlight
        case filledYellow
        case hightlightRed
        case hightlightBlue
        case filledOrange
        case filledGreen
        case filledBlue
        
        var backgroundColor: UIColor {
            switch self {
            case .filled:
                return UIColor(string: "#0376bf")
            case .nude:
                return UIColor.clear
            case .nudeWhite:
                return UIColor(string: "#ffffff")
            case .nudeNoBorder :
                return UIColor(string: "#ffffff")
            case .disabled:
                return UIColor(string: "#e5e5e5")
            case .clear:
                return UIColor.clear
            case .hightlight:
                return UIColor.clear
            case .filledYellow:
                return UIColor(string: "#e5e5e5")
            case .filledOrange:
                return UIColor.clear
            case .filledGreen:
                return UIColor.clear
            case .filledBlue:
                return UIColor.clear
            case .hightlightRed:
                return UIColor.clear
            case .hightlightBlue:
                return UIColor.clear
            }
        }
        
        var titleColor: UIColor {
            switch self {
            case .filled:
                return UIColor(string: "#ffffff")
            case .nude:
                return UIColor(string: "#0376bf")
            case .nudeWhite:
                return UIColor(string: "#0376bf")
            case .nudeNoBorder:
                return UIColor(string: "#0376bf")
            case .disabled:
                return UIColor(string: "#ffffff")
            case .clear:
                return UIColor(string: "#0376bf")
            case .hightlight:
                return UIColor(string: "#ffffff")
            case .filledYellow:
                return UIColor.black
            case .filledOrange:
                return UIColor.orange
            case .filledGreen:
                return UIColor.green
            case .filledBlue:
                return UIColor.blue
            case .hightlightRed:
                return UIColor.red
            case .hightlightBlue:
                return UIColor.blue
            }
        }
        
        var borderColor: UIColor {
            switch self {
            case .filled:
                return UIColor(string: "#0376bf")
            case .nude:
                return UIColor(string: "#0376bf")
            case .nudeWhite:
                return UIColor(string: "#0376bf")
            case .nudeNoBorder:
                return UIColor.clear
            case .disabled:
                return UIColor(string: "#e5e5e5")
            case .clear:
                return UIColor.clear
            case .hightlight:
                return UIColor(string: "#ffffff")
            case .filledYellow:
                return UIColor.yellow
            case .filledOrange:
                return UIColor.orange
            case .filledGreen:
                return UIColor.green
            case .filledBlue:
                return UIColor.blue
            case .hightlightRed:
                return UIColor.red
            case .hightlightBlue:
                return UIColor(string: "#0376bf")
            }
        }
        
        var isEnable: Bool {
            switch self {
            case .disabled:
                return false
            default:
                return true
            }
        }
        
    }
    
    override func layoutSubviews() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setupInit()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    private func setupInit() {
        self.coreButton.layer.cornerRadius = 13
    }
    
    func setAtomic(type: Style = .filled, title: String = "", messageError: String = "") {
        self.coreButton.setTitle(title, for: .normal)
        self.coreButton.setTitleColor(type.titleColor, for: .normal)
        self.coreButton.backgroundColor = type.backgroundColor
        self.coreButton.layer.borderColor = type.borderColor.cgColor
        self.coreButton.isEnabled = type.isEnable
        self.coreButton.layer.borderWidth = 1.0
        
        if !messageError.isEmpty {
            if type.isEnable {
                self.coreMessageError.isHidden = true
            } else {
                self.coreMessageError.isHidden = false
            }
            self.coreMessageError.text = messageError
        } else {
            self.coreMessageError.isHidden = true
        }
        
    }
    
    func setCornerRadius(cornerRadius: CGFloat) {
        self.coreButton.layer.cornerRadius = cornerRadius
    }
    
}
