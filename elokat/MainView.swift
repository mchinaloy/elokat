//
//  MainView.swift
//  elokat
//
//  Created by Mike Chinaloy on 05/02/2017.
//  Copyright © 2017 elokat. All rights reserved.
//

import UIKit
import AVFoundation

class MainView: UIViewController {

    private let mainController = MainController()
    
    @IBOutlet var speechStatus: UILabel!
    @IBOutlet var transcription: UITextView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        mainController.requestSpeechRecognitionAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startButtonPressed(_ sender: Any) {
        do {
            try mainController.startListening(transcription: transcription)
            stopButton.isEnabled = true
            startButton.isEnabled = false
            speechStatus.text = "Listening"
        } catch {
            print("A fatal error occured")
            self.speechStatus.text = "Start listening"
        }
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        mainController.stopListening()
        speechStatus.text = "Start listening"
        stopButton.isEnabled = false
        startButton.isEnabled = true
    }
    

    
}
