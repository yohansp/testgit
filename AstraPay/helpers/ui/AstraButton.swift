//
//  AstraButton.swift
//  AstraPay
//
//  Created by yohanes saputra on 08/06/21.
//

import Foundation
import UIKit

@IBDesignable
final class AstraButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setup()
    }
    
    func setup() {
        self.layer.backgroundColor = UIColor.yellow.cgColor
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 7
    }
}
