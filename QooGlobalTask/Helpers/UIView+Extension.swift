//
//  UIView+Extension.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 22/03/2023.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName : "\(self)",bundle : nil)
    }
}
