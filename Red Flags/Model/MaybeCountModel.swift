//
//  MaybeCountModel.swift
//  Red Flags
//
//  Created by Jake Gordon on 27/10/2022.
//

import Foundation


struct MaybeCountModel {
    
    var maybeCount = 0
    
    mutating func maybeCountFunc(buttonPressed: String) {
        
        if buttonPressed == " Not Sure " {
            maybeCount += 1
            
        }
        
    }
    
    mutating func maybeToZero() {
        
         maybeCount = 0
        
     }
    
    mutating func maybeCalculator(definitelyCount: Int, quizCount: Int) -> Int {
        
        let newCount = quizCount - maybeCount
        let quizPercentage = (Double(definitelyCount) / Double(newCount)) * 100
        let integerPercent = Int(quizPercentage)
        return integerPercent
        
    }
}
