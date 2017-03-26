//
//  SpeechEvaluator.swift
//  elokat
//
//  Created by Mike Chinaloy on 19/03/2017.
//  Copyright © 2017 elokat. All rights reserved.
//

import Foundation

class SpeechEvaluator {
    
    public func generateResponse(input: String) -> String {
        switch input {
        case "question":
            return "That is a great question, but I am rather stupid and don't know the answer"
        case "statement":
            return "Thanks for telling me that"
        case "location_question":
            return "I am not sure where but let me check my internal map"
        case "item_location_question":
            return "Just going to check google for that item, shouldn't be hard to find"
        case "rude_statement":
            return "How rude, try being nice for a change"
        case "offensive_statement":
            return "You are a nasty person sometimes"
        default:
            return "I am not sure I understand, sorry"
        }
    }
    
}
