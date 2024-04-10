//
//  Sound.swift
//  TinniPal
//
//  Created by Ferry Dwianta P on 13/02/24.
//

import Foundation

struct Category: Identifiable, Hashable {
    let id = UUID()
    let title: String
    var sounds: [Sound]
    
    static func getSoundsData() -> [Category] {
        return [
            Category(title: "Nature", sounds: [
                Sound(title: "Rain", inactiveIcon: "cloud.rain", activeIcon: "cloud.rain.fill", isPlaying: false, volume: 0.7),
                Sound(title: "Thunder", inactiveIcon: "cloud.bolt.rain", activeIcon: "cloud.bolt.rain.fill", isPlaying: false, volume: 0.7),
                Sound(title: "Waves", inactiveIcon: "water.waves", activeIcon: "water.waves", isPlaying: false, volume: 0.7),
                Sound(title: "Fire", inactiveIcon: "flame", activeIcon: "flame.fill", isPlaying: false, volume: 0.7),
                Sound(title: "Wind", inactiveIcon: "wind", activeIcon: "wind", isPlaying: false, volume: 0.7),
                Sound(title: "Water", inactiveIcon: "drop", activeIcon: "drop.fill", isPlaying: false, volume: 0.7),
                Sound(title: "Leaves", inactiveIcon: "leaf", activeIcon: "leaf.fill", isPlaying: false, volume: 0.7),
                Sound(title: "Jungle", inactiveIcon: "tree", activeIcon: "tree.fill", isPlaying: false, volume: 0.7)
            ]),
            Category(title: "Animal", sounds: [
                Sound(title: "Birds", inactiveIcon: "bird", activeIcon: "bird.fill", isPlaying: false, volume: 0.7),
                Sound(title: "Cricket", inactiveIcon: "cricket", activeIcon: "cricket", isPlaying: false, volume: 0.7),
                Sound(title: "Frogs", inactiveIcon: "frog", activeIcon: "frog.fill", isPlaying: false, volume: 0.7),
                Sound(title: "Owl", inactiveIcon: "owl", activeIcon: "owl.fill", isPlaying: false, volume: 0.7),
                Sound(title: "Cicadas", inactiveIcon: "cicada", activeIcon: "cicada", isPlaying: false, volume: 0.7),
                Sound(title: "Squirrel", inactiveIcon: "squirrel", activeIcon: "squirrel.fill", isPlaying: false, volume: 0.7)
            ]),
            Category(title: "Music", sounds: [
                Sound(title: "Moment", inactiveIcon: "music.note", activeIcon: "music.note", isPlaying: false, volume: 0.7),
                Sound(title: "Zen", inactiveIcon: "music.note", activeIcon: "music.note", isPlaying: false, volume: 0.7),
                Sound(title: "Calm", inactiveIcon: "music.note", activeIcon: "music.note", isPlaying: false, volume: 0.7)
            ]),
        ]
    }
}

struct Sound: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let inactiveIcon: String
    let activeIcon: String
    var isPlaying: Bool
    var volume: Double
}
