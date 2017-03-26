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
    
    private let languageEngine = AwsLanguageEngine()
    private let speechEvaluator = SpeechEvaluator()
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
            languageEngine.getResponse(input: text) { (response) in
                self.speechSynthesizer.speak(text: self.speechEvaluator.generateResponse(input: response), audioSession: audioSession)
            }
        }
    }
    
}
