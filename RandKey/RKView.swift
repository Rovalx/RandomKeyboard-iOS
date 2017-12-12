//
//  RKView.swift
//  RandomKeyboard
//
//  Created by Dominik Majda on 16.10.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RKView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return UIColor.clear
            }
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
}
