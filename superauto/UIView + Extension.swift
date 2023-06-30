//
//  UIView + Extension.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 13/02/2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
    get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
