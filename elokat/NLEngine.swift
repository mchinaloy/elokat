//
//  NLResponseProcessor.swift
//  elokat
//
//  Created by Mike Chinaloy on 12/03/2017.
//  Copyright © 2017 elokat. All rights reserved.
//

import Foundation

class NLEngine {
    
    let vocabulary = Vocabulary()
    
    func getResponse(input: String) -> String {
        let tokenizedInput = wordTokenizer(input: input)
        let emotion = emotionEvaluator(tokenizedInput: tokenizedInput)
        let context = contextEvaluator(tokenizedInput: tokenizedInput)
        return constructResponse(emotion: emotion, context: context)
    }
    
    private func constructResponse(emotion: String, context: String) -> String {
        if(emotion == Emotion.positive.rawValue) {
            return positiveResponse(context: context)
        } else if (emotion == Emotion.neutral.rawValue) {
            return neutralResponse(context: context)
        }
        return negativeResponse(context: context)
    }
    
    private func positiveResponse(context: String) -> String {
        if(context == Context.question.rawValue) {
            return "That is a great question! Though I am rather dumb so can't answer it"
        } else {
            return "Great, I'm glad you feel that way"
        }
    }
    
    private func negativeResponse(context: String) -> String {
        if(context == Context.question.rawValue) {
            return "Yeah I am not sure what we can do about that"
        } else {
            return "That is not good at all!"
        }
    }
    
    private func neutralResponse(context: String) -> String {
        if(context == Context.question.rawValue) {
            return "Interesting, let me think about that for a while"
        } else {
            return "I am not entirely sure about that"
        }
    }
    
    private func wordTokenizer(input: String) -> [String] {
        return input.components(separatedBy: " ")
    }
    
    private func emotionEvaluator(tokenizedInput: [String]) -> String {
        var emotionScore = 0
        for word in tokenizedInput {
            for (emotion, score) in vocabulary.emotionIndicators {
                if (word == emotion) {
                    emotionScore = emotionScore + score
                }
            }
        }
        print("emotionScore=\(emotionScore)")
        if (emotionScore > 5) {
            return Emotion.positive.rawValue
        } else if(emotionScore < 0) {
            return Emotion.negative.rawValue
        }
        return Emotion.neutral.rawValue
    }
    
    private func contextEvaluator(tokenizedInput: [String]) -> String {
        var contextScore = 0
        for word in tokenizedInput {
            for (context, score) in vocabulary.questionContextIndicators {
                if (word == context) {
                    contextScore = contextScore + score
                }
            }
        }
        print("contextScore=\(contextScore)")
        if (contextScore >= 5) {
            return Context.question.rawValue
        }
        return Context.statement.rawValue
    }
    
}
