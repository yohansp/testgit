//
//  WaitDlg.swift
//  AstraPay
//
//  Created by yohanes saputra on 09/06/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    static let tagContainer = 10000
    static let tagSubview = 10001
    static let btmSheetAnimationDuration = 0.15
    
    func showWait() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func hideWait() {
        dismiss(animated: false, completion: nil)
    }
    
    func showPopUpBottomView(withView: UIView, height: CGFloat , isUseNavigationBar : Bool = true){
        
        let tagPlaceholder = UIViewController.tagContainer
        let tagSubView = UIViewController.tagSubview
        
        
        let viewContainer = UIView()
        viewContainer.frame = UIScreen.main.bounds
        viewContainer.tag = tagPlaceholder
        viewContainer.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        viewContainer.addTapGestureRecognizer(action: {
//            self.removePlaceHolderView()
//        })
        
        let subView = withView
        
        
        subView.frame = CGRect(x: 0,
                               y: (UIScreen.main.bounds.height + height),
                               width: self.view.frame.width, height: height)
        subView.isUserInteractionEnabled = false
        //let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGestureActs))
        
        var accLabel = "false"
        if isUseNavigationBar {
            accLabel = "true"
        }
        
        
//        gesture.accessibilityLabel = accLabel
//        subView.addGestureRecognizer(gesture)
        subView.tag = tagSubView
        
        
//        viewContainer.addSubview(subView)
        
        self.view.addSubview(viewContainer)
        self.view.addSubview(subView)
        
        var yPos : CGFloat = (UIScreen.main.bounds.height - height)
        if !isUseNavigationBar {
           yPos = yPos + 44
        }
        //Show view with animation
        UIView.animate(withDuration: UIViewController.btmSheetAnimationDuration, animations: {
            subView.frame = CGRect(x: 0,
                                   y: yPos,
                                   width: self.view.frame.width,
                                   height: height)
        }, completion: {
            finished in
            if finished {
                subView.isUserInteractionEnabled = true
            }
        })
    }
}
