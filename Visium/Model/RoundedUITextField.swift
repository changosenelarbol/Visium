//
//  RoundedUITextField.swift
//  Visium
//
//  Created by developer on 13/04/21.
//

import UIKit

class RoundedUITextField: UITextField {
    
    var testPadding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    @IBInspectable var isSecure: Bool = false {
        didSet {
            if isSecure {
                let clearButton = UIButton(frame: CGRect(x: self.frame.width + 20, y: 2, width: 30 , height: 30))
                let originalImage = UIImage(named: "showPasswordButton")
                let tintedImage = originalImage?.withRenderingMode(.alwaysTemplate)
                clearButton.setImage(tintedImage, for: .normal)
                clearButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 4, right: 0)
                self.rightView = clearButton
                clearButton.addTarget(self, action: #selector(clearClicked(sender:)), for: .touchUpInside)
                self.clearButtonMode = .never
                self.rightViewMode = .always
                
            }
        }
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.textColor = .white
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    }
    
    @objc func clearClicked(sender: UIButton)
    {
        self.isSecureTextEntry = !isSecureTextEntry
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2.0
        self.layer.masksToBounds = true
        self.textColor = .white
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 50/255, green: 162/255, blue: 255/255, alpha: 1).cgColor
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: testPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: testPadding)
    }
    
    
}
