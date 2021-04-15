//
//  RoundedUIButton.swift
//  Visium
//
//  Created by developer on 13/04/21.
//

import UIKit

class RoundedUIButton: UIButton {

    
    @IBInspectable var filled: Bool = false {
        didSet {
            if filled {
                self.backgroundColor = UIColor(red: 50/255, green: 162/255, blue: 255/255, alpha: 1)
            } else {
                self.backgroundColor = .clear
                self.layer.borderWidth = 1
                self.layer.borderColor = UIColor.white.cgColor
            }
        }
    }

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      //  self.backgroundColor = UIColor(red: 82/255, green: 163/255, blue: 248/255, alpha: 1)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = self.frame.height / 2.0
        self.layer.masksToBounds = true

    }
    
    func setTitle(title: String) {
        let str = NSMutableAttributedString(string: title)
        str.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, 0))
        self.setAttributedTitle(str, for: .normal)
    }

}
