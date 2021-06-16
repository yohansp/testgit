//
//  PinTextField.swift
//  astrapay
//
//  Created by Guntur Budi on 11/08/20.
//  Copyright © 2020 Tirta Rivaldi. All rights reserved.
//

import UIKit

class InputLoginTextField: UITextField {
      var backspaceCalled: (()->())?
      override func deleteBackward() {
        super.deleteBackward()
        backspaceCalled?()
      }
}
