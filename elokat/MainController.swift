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

    private let audioSession = AVAudioSession.sharedInstance()
    private let speechService = SpeechService()
    private let audioEngine = AVAudioEngine()
    private let speechRegonizer = SFSpeechRecognizer(locale: Locale(identifier: "en-GB"))!

    private var speechText: String!
    private var speechEnabled = false
    private var transcription: UITextView!
    private var recognitionTask: SFSpeechRecognitionTask?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    override init () {
        super.init()
        speechRegonizer.delegate = self
    }
    
    public func startListening(transcription: UITextView!) throws {
        speechEnabled = true
        setRecognitionRequest()
        configureAudioSession()
        speechRegonizer.recognitionTask(with: recognitionRequest!) { result, error in
            var isFinal = false
            if let result = result {
                if(self.speechEnabled) {
                    self.speechText = result.bestTranscription.formattedString
                    transcription.text = self.speechText
                    isFinal = result.isFinal
                }
            }
            
            if error != nil || isFinal {
                self.stopListening()
            }
        }
    }
    
    private func setRecognitionRequest() {
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
    }
    
    private func configureAudioSession() {
        do {
            if let recognitionTask = recognitionTask {
                recognitionTask.cancel()
                self.recognitionTask = nil
            }
        
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
            guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input node") }
        
            let recordingFormat = inputNode.outputFormat(forBus: 0)
        
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                self.recognitionRequest!.append(buffer)
            }
            audioEngine.prepare()
            try audioEngine.start()
        } catch {
            print("An error occurred whilst configuring audioSession")
        }
    }
    
    public func stopListening() {
        self.speechService.process(text: speechText, audioSession: self.audioSession)
        print("Stopped listening")
        speechEnabled = false
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
