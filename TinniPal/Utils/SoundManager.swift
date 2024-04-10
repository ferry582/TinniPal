//
//  SoundManager.swift
//
//
//  Created by Ferry Dwianta P on 19/02/24.
//

import Foundation
import AVFoundation

class SoundManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    static let shared: SoundManager = SoundManager()
    
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    
    @Published var stereoValue: Float = 0
    @Published var soundsData = Category.getSoundsData()
    
    override init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func play(title: String, volume: Float) {
        guard let player = getAudioPlayer(for: title) else {
            return
        }
        player.volume = volume
        player.numberOfLoops = -1
        player.pan = stereoValue
        player.prepareToPlay()
        player.play()
        audioPlayers[title] = player
    }
    
    func stop(title: String) {
        audioPlayers[title]?.stop()
        audioPlayers.removeValue(forKey: title)
    }
    
    func updateSoundVolume(title: String, volume: Float) {
        audioPlayers[title]?.volume = volume
    }
    
    func pauseAllSounds() {
        audioPlayers.forEach { key, value in
            audioPlayers[key]?.stop()
        }
    }
    
    func playAllSounds() {
        audioPlayers.forEach { key, value in
            audioPlayers[key]?.play()
        }
    }
    
    func stopAllSounds() {
        for categoryIndex in soundsData.indices {
            for soundIndex in soundsData[categoryIndex].sounds.indices {
                soundsData[categoryIndex].sounds[soundIndex].isPlaying = false
            }
        }
        audioPlayers.removeAll()
    }
    
    func fadeOutAllSounds(duration: Double) {
        audioPlayers.forEach { key, value in
            audioPlayers[key]?.setVolume(0, fadeDuration: duration)
        }
    }
    
    func updatePlayersPan(value: Float) {
        stereoValue = value
        audioPlayers.forEach { key, audio in
            audioPlayers[key]?.pan = value
        }
    }
    
    private func getAudioPlayer(for title: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: title, withExtension: "mp3") else {
            return nil
        }
        
        guard let player = audioPlayers[title] else {
            let player = try? AVAudioPlayer(contentsOf: url)
            return  player
        }
        
        guard player.isPlaying else { return player }
        player.delegate = self
        return player
    }
}
