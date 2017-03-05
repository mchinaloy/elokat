//
//  MainController.swift
//  elokat
//
//  Created by Mike Chinaloy on 05/03/2017.
//  Copyright © 2017 elokat. All rights reserved.
//

import Foundation
import Speech
import UIKit

class MainController: NSObject, SFSpeechRecognizerDelegate {

    private let speechEngine = SpeechEngine()
    private let audioEngine = AVAudioEngine()
    private let speechRegonizer: SFSpeechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-GB"))!
    
    private var recognitionTask: SFSpeechRecognitionTask?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    public func startListening(transcription: UITextView!) throws {
        
        speechRegonizer.delegate = self
        
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input node") }
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        
        recognitionRequest.shouldReportPartialResults = true
        
        speechRegonizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            if let result = result {
                let speechText = result.bestTranscription.formattedString
                transcription.text = speechText
                self.speechEngine.process(text: speechText)
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.stopListening()
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        
        try audioEngine.start()
    }
    
    public func stopListening() {
        audioEngine.inputNode?.removeTap(onBus: 0)
        audioEngine.stop()
        recognitionTask?.cancel()
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        recognitionTask = nil
    }
    
    public func requestSpeechRecognitionAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    break
                default:
                    print(authStatus)
                }
            }
        }
    }
}
