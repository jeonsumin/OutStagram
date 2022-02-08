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
    func addBottomBorder(){
           let bottomLine = CALayer()
           bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
           bottomLine.backgroundColor = UIColor.lightGray.cgColor
           borderStyle = .none
           layer.addSublayer(bottomLine)
       }
    
}
