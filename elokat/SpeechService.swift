//
//  ProcessingEngine.swift
//  elokat
//
//  Created by Mike Chinaloy on 05/03/2017.
//  Copyright © 2017 elokat. All rights reserved.
//

import Foundation
import AVFoundation

class SpeechService {
    
    private let nlEngine = NLEngine()
    private let vocabulary = Vocabulary()
    private let speechSynthesizer = SpeechSynthesizer()
    
    public func process(text: String, audioSession: AVAudioSession) {
        print("Attempting to match \(text)")
        var intentMatched = false
        if let response = vocabulary.intents[text.lowercased()] {
            intentMatched = true
            speechSynthesizer.speak(text: response, audioSession: audioSession)
        }
        
        if(!intentMatched) {
            let response = nlEngine.getResponse(input: text)
            speechSynthesizer.speak(text: response, audioSession: audioSession)
        }
    }
    
}
