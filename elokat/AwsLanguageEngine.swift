//
//  AwsNlpEngine.swift
//  elokat
//
//  Created by Mike Chinaloy on 19/03/2017.
//  Copyright © 2017 elokat. All rights reserved.
//

import Foundation
import Alamofire
import AWSCore
import AWSMachineLearning

class AwsLanguageEngine: LanguageEngine {

    private let modelId = "ml-MJ8z7grvcS0"
    private let endpoint = "https://realtime.machinelearning.eu-west-1.amazonaws.com"
    
    func getResponse(input: String, completion: @escaping (String) -> Void) {
        let machineLearning = AWSMachineLearning.default()
        let getMlModelInput = AWSMachineLearningGetMLModelInput()
        getMlModelInput!.mlModelId = modelId;
        
        let record = createRecord(input: input)
        
        // Create a Predict request with your ML Model id and the appropriate
        let predictInput = AWSMachineLearningPredictInput()
        predictInput!.predictEndpoint = endpoint
        predictInput!.mlModelId = modelId
        predictInput!.record = record
        
        let response = machineLearning.predict(predictInput!)
        
        response.continueOnSuccessWith { (task) -> Any? in
            let label = response.result?.prediction?.predictedLabel
            completion(label!)
            return nil
        }
    }
    
    private func createRecord(input: String) -> [String:String] {
        var record = [String:String]()
        record["input"] = input
        return record
    }
    
}
