//
//  SpeechService.swift
//  elokat
//
//  Created by Mike Chinaloy on 05/03/2017.
//  Copyright © 2017 elokat. All rights reserved.
//

import Foundation
import Speech

class SpeechService: NSObject, AVSpeechSynthesizerDelegate {
    
    private let synth = AVSpeechSynthesizer()
    
    func speak(text: String) {
        if !synth.isSpeaking {
            print("Speaking \(text)")
            let myUtterance = AVSpeechUtterance(string: text)
            print(AVSpeechSynthesisVoice.speechVoices())
            myUtterance.rate = 0.5
            synth.speak(myUtterance)
        } else {
            print("Already speaking, ignoring input")
            synth.continueSpeaking()
        }
    }
    
}
