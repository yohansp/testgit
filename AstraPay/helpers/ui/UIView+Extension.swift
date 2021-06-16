//
//  UIView+Extension.swift
//  AstraPay
//
//  Created by yohanes saputra on 14/06/21.
//

import Foundation
import UIKit

extension UIView {

    func xibSetup(nibName : String) {
        var containerView = UIView()
        containerView = loadViewFromNib(nibName: nibName)
        containerView.frame = bounds
        containerView.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
        addSubview(containerView)
    }
    
    func loadViewFromNib(nibName : String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func roundedTopMessage(isFullScreen : Bool = false){
        DispatchQueue.main.async {
            var bound = CGRect()
            if isFullScreen{
                bound = UIScreen.main.bounds
            }else {
                bound = self.bounds
            }
            let path = UIBezierPath(roundedRect:  bound,
                                byRoundingCorners: [.topRight,.topLeft,.topRight],
                                cornerRadii: CGSize(width: 20, height:  20))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}
