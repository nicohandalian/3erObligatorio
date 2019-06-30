//
//  MusicManager.swift
//  3erObligatorio
//
//  Created by Nicolás Handalian on 6/30/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import AVFoundation

class MusicManager{
    static let shared = MusicManager()
    var audioPlayer: AVAudioPlayer?
    
    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "backgroundMusic", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
}
