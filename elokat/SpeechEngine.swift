//
//  ProcessingEngine.swift
//  elokat
//
//  Created by Mike Chinaloy on 05/03/2017.
//  Copyright © 2017 elokat. All rights reserved.
//

import Foundation
import AVFoundation

class SpeechEngine {
    
    private let coreIntents: CoreIntents = CoreIntents()
    private let speechService: SpeechService = SpeechService()
    
    public func process(text: String) {
        print("Attempting to match \(text)")
        if let response = coreIntents.intents[text.lowercased()] {
            speechService.speak(text: response)
        } else {
            speechService.speak(text: "Sorry, I don't understand")
        }

    }
    
}
