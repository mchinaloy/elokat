//
//  Intent.swift
//  elokat
//
//  Created by Mike Chinaloy on 05/03/2017.
//  Copyright © 2017 elokat. All rights reserved.
//

import Foundation

class Vocabulary {
    
    let intents: [String: String] = [
        "hello":"hi there",
        "what is your name":"call me swifty",
        "what are you":"I am a super advanced artificial intelligence obviously",
        "how are you":"good thank you, how are you",
        "goodbye":"see ya",
        "help":"ask me anything",
        "login":"logging you in",
        "wager":"wagering",
        "logout":"logging you out",
        "list":"pre-configured intents include: hello, what is your name, what are you, how are you, help, login, wager and logout"
    ]
    
    let emotions: [String] = [
        "positive",
        "negative",
        "neutral"
    ]
    
    let emotionIndicators: [String: Int] = [
        "great":10,
        "like":8,
        "nice":7,
        "good":8,
        "fine":5,
        "bad":-10
    ]
    
    let questionContextIndicators: [String: Int] = [
        "what":10,
        "where":10,
        "which":10,
        "how":10,
        "when":10,
        "you": 5
    ]
    
    let statementContextIndicators: [String: Int] = [
        "you": 5,
        "I'm":5,
        "I am":5,
        "thank you":5
    ]
}
