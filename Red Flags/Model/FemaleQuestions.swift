//
//  FemaleQuestions.swift
//  Red Flags
//
//  Created by Jake Gordon on 08/09/2022.
//

import Foundation


struct FemaleQuestions: QuestionChoice {
    
    var questionNumber = 0
    var quiz =
    
         [" Does she try to justify things you know are wrong? ", " Is she selfish in bed? ", " Do you have a gut feeling that something is wrong? ", " Does she invalidate your opinions/experiences? ", " Does she push your boundaries? ", " Is she incapable of apologising? ", " Does she guilt-trip you? ", " Does she talk badly of her exes? ", " Is she too affectionate too soon? ", " Is she rushing commitment? ", " Does she forget important occasions in your life? ", " Is she still in regular contact with her exes? ", " Does she treat service staff poorly? ", " Does she disappear and then show up when she needs you? ", " Does she squirm when you make future plans? ", " Is she reluctant to express her feelings for you? ", " Does she have double standards for you both? ", " Has she ever cheated on an ex? ", " Does she lack close genuine friendships? ", " Does she maintain distance between you and her family/friends? ", " Does she have a money spending issue? ", " Is she manipulative? ", " Does she flirt with other people in front of you? ", " Does she get angry if you disagree with something she believes? ", " Is she possessive/controlling? "]
    
    func getQuestionText() -> String {
    
                return quiz[questionNumber]
    
            }
    
    func getProgress() -> Float {
    
                return Float(questionNumber) / Float(quiz.count)
    
            }
    
    mutating func nextQuestion() {
    
                if questionNumber < quiz.count {
    
                     questionNumber += 1
    
                 }
        
    }
    
    mutating func questionCountToZero() {

        questionNumber = 0
        
    }
    
    func getQuizCount() -> Int {
        
            return quiz.count
        
        }
    
}
