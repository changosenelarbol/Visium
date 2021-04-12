//
//  VideoPlayer.swift
//  Visium
//
//  Created by developer on 12/04/21.
//

import UIKit
import AVKit

class VideoPlayer: UIView {
    
    @IBOutlet weak var viewPlayer: UIView!
    var player: AVPlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initXIB()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initXIB()
    }
    
    fileprivate func initXIB() {
        if let viewFromXIB = Bundle.main.loadNibNamed("VideoPlayer", owner: self, options: nil)![0] as? UIView {
            viewFromXIB.frame = self.bounds
            self.addSubview(viewFromXIB)
            addPlayerToView(self.viewPlayer)

        }
    }
   
    fileprivate func addPlayerToView(_ view: UIView) {
        self.player = AVPlayer()
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(self, selector: #selector(playerEndPlay), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func playVideo(_ fileName: String, of type: String) {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: type) {
            let videoUrl = URL(fileURLWithPath: filePath)
            let playerItem = AVPlayerItem(url: videoUrl)
            player?.replaceCurrentItem(with: playerItem)
            player?.play()
        }
        
    }
    
    @objc func playerEndPlay() {
        
    }

}
