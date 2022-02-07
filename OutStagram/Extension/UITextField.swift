//
//  UITextField.swift
//  OutStagram
//
//  Created by Terry on 2022/02/07.
//

import UIKit

extension UITextField {
    func addLeftPadding(){
          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
          self.leftView = paddingView
          self.leftViewMode = ViewMode.always
        }
    
}
