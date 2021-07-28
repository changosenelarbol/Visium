//
//  Alert.swift
//  Visium
//
//  Created by developer on 28/07/21.
//

import UIKit

class Alert: UIView {

    static let shared = Alert()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    
    func setUpView() {
        Bundle.main.loadNibNamed("Alert", owner: self, options: nil)
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.backgroundView.layer.cornerRadius = 10

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func okAction(_ sender: Any) {
        self.parentView.removeFromSuperview()
    }
    
    enum AlertType {
        case succes
        case warning
        case failure
    }
    
    func showAlert(title: String, alertType: AlertType) {
        
        switch alertType {
        case .succes: 
            self.iconImage.image = UIImage(systemName: "checkmark.circle.fill")
        case .warning:
            self.iconImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
        case .failure:
            self.iconImage.image = UIImage(systemName: "xmark.seal.fill")
        }
        self.textLabel.text = title
        self.backgroundView.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(self.parentView)
        UIView.animate(withDuration: 0.5) {
            self.backgroundView.alpha = 1
        }
     
    }
}
