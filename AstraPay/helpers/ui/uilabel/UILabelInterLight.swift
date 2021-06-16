//
//  UILabelInterLight.swift
//  astrapay
//
//  Created by Guntur Budi on 14/11/20.
//  Copyright © 2020 Tirta Rivaldi. All rights reserved.
//

import UIKit

@IBDesignable
class UILabelInterLight: UILabel {

    override func prepareForInterfaceBuilder() {
        setUILabel()
    }
    
    override func awakeFromNib() {
        setUILabel()
    }
    
    private func setUILabel() {
        //font = UIFont.font(size: font.pointSize, fontType: .interLight)
        font = UIFont.systemFont(ofSize: font.pointSize, weight: .light)
    }

}
