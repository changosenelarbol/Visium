//
//  OnboardingCollectionViewCell.swift
//  Visium
//
//  Created by developer on 12/04/21.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    var onboardingSlide: OnboardingSlide?
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    func setUpCell(onboardingSlide: OnboardingSlide) {
        self.onboardingSlide = onboardingSlide
        
        if onboardingSlide.isVideo {
            let playerView = VideoPlayer(frame: self.bounds)
            playerView.playVideo("video1", of: "mp4")
            self.contentView.addSubview(playerView)
            
        } else {
            let imageView = UIImageView(frame: self.bounds)
            imageView.image = UIImage(named: "VisiumLogo")
            self.contentView.addSubview(imageView)
        }
    }
    
   
    
    
    
  
    
  
    
}
