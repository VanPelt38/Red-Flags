//
//  NewAttempt.swift
//  Red Flags
//
//  Created by Jake Gordon on 14/04/2022.
//

import Foundation


struct Answers {

var definitelyCount = 0

mutating func definitelyCountFunc(buttonPressed: String) -> Int {
    
    if buttonPressed == " Definitely " {
        
        definitelyCount += 1
        
    }
    
    return definitelyCount
    
}

    func getAnswerOption(maybePercentage: Int) -> String {
      
    let answerOptions = [" Don't stress partner - your new fling is A-OK. Better lock them down fast! ", " Well, there seem to be a few concerns, but hey - no one's perfect, right? Take it slow, and work on building trust. ", " Sounds like your new partner isn't all you'd hoped they'd be. Now's the time to either have a frank discussion, or drop them like a hot buttery potato. ", " Your new partner is a psycho narcissist with no soul. They will eat your heart for breakfast. Run. Now. "]

        if maybePercentage == 1000 {
           
    switch definitelyCount {
        
    case 0...6:
        return answerOptions[0]
    case 7...12:
        return answerOptions[1]
    case 13...19:
        return answerOptions[2]
    case 20...:
        return answerOptions[3]
    default:
        return ""
        
    }
            
        } else {
            
            switch maybePercentage {
                
            case 0...25:
                return answerOptions[0]
            case 26...50:
                return answerOptions[1]
            case 51...75:
                return answerOptions[2]
            case 76...:
                return answerOptions[3]
            default:
                return ""
                
            }
            
        }
        
}
    
   mutating func defToZero() {
       
        definitelyCount = 0
       
    }
    
}
