//
//  Ext_UITextField.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 5/12/25.
//

import Foundation
import UIKit

extension UITextField {
    func addLeftPadding(width: CGFloat = 8) {
        // width값에 원하는 padding 값을 넣어줍니다.
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
