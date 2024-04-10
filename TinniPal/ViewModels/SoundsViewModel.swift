//
//  SoundsViewModel.swift
//  TinniPal
//
//  Created by Ferry Dwianta P on 14/02/24.
//

import SwiftUI
import Combine

class SoundsViewModel: ObservableObject {
    private var soundManager = SoundManager.shared
    private var cancellables: Set<AnyCancellable> = []
    private var timer: Timer?
    
    @Published var soundsData = [Category]()
    @Published var timerCount = "00:00:00"
    @Published var isAnySoundPlaying = false
    @Published var isSoundsPlayed = false
    @Published var isTimerOn = false
    
    init() {
        soundManager.$soundsData.sink { [weak self] data in
            self?.soundsData = data
            let isAnySoundPlaying = data.contains { category in
                category.sounds.contains { $0.isPlaying }
            }
            if self?.isAnySoundPlaying != isAnySoundPlaying {
                self?.isAnySoundPlaying = isAnySoundPlaying
                self?.isSoundsPlayed = isAnySoundPlaying
                if self!.isTimerOn && !isAnySoundPlaying {
                    self?.stopTimer()
                }
            }
        }.store(in: &cancellables)
    }
    
    func startStopButtonClicked() {
        isSoundsPlayed.toggle()
        if isSoundsPlayed {
            soundManager.playAllSounds()
        } else {
            soundManager.pauseAllSounds()
        }
    }
    
    func startCountDownTimer(deadline: TimeInterval) {
        isTimerOn = true
        var timeLeft = deadline
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.timerCount = self?.timeString(time: timeLeft) ?? "00:00:00"
            timeLeft -= 1
            if timeLeft < 0 {
                self?.stopTimer()
                self?.isTimerOn = false
                self?.soundManager.stopAllSounds()
            } else if timeLeft < 4 {
                self?.soundManager.fadeOutAllSounds(duration: 3)
            }
        }
    }
    
    func stopCountDownTimer() {
        stopTimer()
    }
    
    func soundClicked(categoryId: UUID, soundId: UUID) {
        if let categoryIndex = soundManager.soundsData.firstIndex(where: { $0.id == categoryId }),
           let soundIndex = soundManager.soundsData[categoryIndex].sounds.firstIndex(where: { $0.id == soundId }) {
            soundManager.soundsData[categoryIndex].sounds[soundIndex].isPlaying.toggle()
            
            let sound = soundManager.soundsData[categoryIndex].sounds[soundIndex]
            if sound.isPlaying {
                soundManager.play(title: sound.title, volume: Float(sound.volume))
                isSoundsPlayed = true
                soundManager.playAllSounds()
            } else {
                soundManager.stop(title: sound.title)
            }
        }
    }
    
    private func timeString(time: TimeInterval) -> String {
        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    private func stopTimer() {
        isTimerOn = false
        timerCount = "00:00:00"
        timer?.invalidate()
        timer = nil
    }
}
