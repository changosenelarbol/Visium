//
//  CheckBoxWithTitleView.swift
//  Visium
//
//  Created by developer on 14/04/21.
//

import UIKit

class CheckBoxWithTitleView: UIView {

    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var isCheked = false {
        didSet {
            self.checkView.backgroundColor = isCheked ? UIColor(red: 50/255, green: 162/255, blue: 255/255, alpha: 1) : .clear
        }
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
      
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        if let viewFromXIB = Bundle.main.loadNibNamed("CheckBoxWithTitleView", owner: self, options: nil)![0] as? UIView {
            viewFromXIB.frame = self.bounds
            self.addSubview(viewFromXIB)

        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        self.addGestureRecognizer(gesture)
        self.isCheked = false
       }
    
    @objc func didTap() {
        isCheked = !isCheked
    }
    
    override func layoutSubviews() {
//        self.checkView.layer.cornerRadius = self.checkView.bounds.height / 2
//        self.checkView.layer.masksToBounds = true
        self.checkView.layer.borderWidth = 1
        self.checkView.layer.borderColor = UIColor.white.cgColor
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    

}
