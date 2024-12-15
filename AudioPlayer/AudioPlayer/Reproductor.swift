//
//  Reproductor.swift
//  AudioPlayer
//
//  Created by Alan Ulises on 29/11/24.
//

import Foundation
import AVKit
import AVFoundation

class Reproductor:AVPlayerViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let laURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"){
            self.player = AVPlayer(url: laURL)
        }
    }
}
