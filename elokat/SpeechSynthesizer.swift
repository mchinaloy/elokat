//
//  SpeechService.swift
//  elokat
//
//  Created by Mike Chinaloy on 05/03/2017.
//  Copyright © 2017 elokat. All rights reserved.
//

import Foundation
import Speech

class SpeechSynthesizer: NSObject, AVSpeechSynthesizerDelegate {
    
    private let synth = AVSpeechSynthesizer()
    private var audioSession: AVAudioSession!
    
    override init() {
        super.init()
        synth.delegate = self
    }
    
    func speak(text: String, audioSession: AVAudioSession) {
        do {
            print("Starting to speak, setting mode to Playback")
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch{
            print("An error occurred whilst trying to set audio session category")
        }
        self.audioSession = audioSession
        synth.stopSpeaking(at: AVSpeechBoundary.immediate)
        print("Speaking \(text)")
        let myUtterance = AVSpeechUtterance(string: text)
        myUtterance.rate = 0.5
        synth.speak(myUtterance)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        do {
            print("Stopped speaking, setting mode to Record")
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
        } catch {
            print("An error occurred whilst trying to set audio session category")
        }
    }
    
}
