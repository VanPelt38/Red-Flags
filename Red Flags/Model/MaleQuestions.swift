//
//  Question.swift
//  Red Flags
//
//  Created by Jake Gordon on 21/03/2022.
//

import Foundation


protocol QuestionChoice {
    
    var questionNumber: Int { get }
    var quiz: [String] { get }
    func getQuestionText() -> String
    func getProgress() -> Float
    mutating func nextQuestion()
    mutating func questionCountToZero()
    func getQuizCount() -> Int
    
}

struct MaleQuestions: QuestionChoice {
   
    var questionNumber = 0
    var quiz =
    
         [" Does he try to justify things you know are wrong? ", " Is he selfish in bed? ", " Do you have a gut feeling that something is wrong? ", " Does he invalidate your opinions/experiences? ", " Does he push your boundaries? ", " Is he incapable of apologising? ", " Does he guilt-trip you? ", " Does he talk badly of his exes? ", " Is he too affectionate too soon? ", " Is he rushing commitment? ", " Does he forget important occasions in your life? ", " Is he still in regular contact with his exes? ", " Does he treat service staff poorly? ", " Does he disappear and then show up when he needs you? ", " Does he squirm when you make future plans? ", " Is he reluctant to express his feelings for you? ", " Does he have double standards for you both? ", " Has he ever cheated on an ex? ", " Does he lack close genuine friendships? ", " Does he maintain distance between you and his family/friends? ", " Does he have a money spending issue? ", " Is he manipulative? ", " Does he flirt with other people in front of you? ", " Does he get angry if you disagree with something he believes? ", " Is he possessive/controlling? "]
    
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


    

    

