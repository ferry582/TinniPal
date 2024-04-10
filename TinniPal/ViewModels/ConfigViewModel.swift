//
//  ConfigViewModel.swift
//
//
//  Created by Ferry Dwianta P on 17/02/24.
//

import Foundation
import Combine

class ConfigViewModel: ObservableObject {
    private let soundManager = SoundManager.shared
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var soundsData = [Category]()
    @Published var stereoValue: Float = 0
    @Published var isAnySoundPlaying = false
    
    init() {
        soundManager.$soundsData.sink { [weak self] data in
            self?.soundsData = data
            self?.isAnySoundPlaying = data.contains { category in
                category.sounds.contains { $0.isPlaying }
            }
        }.store(in: &cancellables)
        
        soundManager.$stereoValue.sink { [weak self] value in
            self?.stereoValue = value
        }.store(in: &cancellables)
    }
    
    func updateSoundVolume(categoryIndex: Int, soundIndex: Int, title: String, value: Double) {
        soundManager.soundsData[categoryIndex].sounds[soundIndex].volume = value
        soundManager.updateSoundVolume(title: title, volume: Float(value))
    }
    
    func updateSoundsStereo(value: Float) {
        soundManager.updatePlayersPan(value: value)
    }
    
    func clearAllSounds() {
        soundManager.stopAllSounds()
    }
}
