//
//  NLPEngine.swift
//  elokat
//
//  Created by Mike Chinaloy on 19/03/2017.
//  Copyright © 2017 elokat. All rights reserved.
//

import Foundation

protocol LanguageEngine {
    func getResponse(input: String, completion: @escaping (String) -> Void)
}
