import UIKit


@IBDesignable
public class RKTextView: UITextView {
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
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
