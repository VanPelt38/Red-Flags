//
//  ViewController2WelcomeViewController.swift
//  Red Flags
//
//  Created by Jake Gordon on 21/03/2022.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    //MARK: - Outlets & Properties

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var definitelyButton: UIButton!
    @IBOutlet weak var definitelyNotButton: UIButton!
    @IBOutlet weak var maybeButton: UIButton!
    
    var questions: QuestionChoice? = nil
    private var answer = Answers()
    private var maybe = MaybeCountModel()
    private var definitelyCount = 0
    private var isLandscape: Bool = false
    
    //MARK: - View Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateFunc()
        
        background.backgroundColor = UIColor(named: K.redBackColour)
        
        definitelyButton.layer.cornerRadius = 25
        definitelyButton.clipsToBounds = true
        definitelyButton.layer.borderWidth = 1.00
        definitelyButton.layer.borderColor = UIColor.black.cgColor
        
        definitelyNotButton.layer.cornerRadius = 25
        definitelyNotButton.clipsToBounds = true
        definitelyNotButton.layer.borderWidth = 1.00
        definitelyNotButton.layer.borderColor = UIColor.black.cgColor
        
        maybeButton.layer.cornerRadius = 25
        maybeButton.clipsToBounds = true
        maybeButton.layer.borderWidth = 1.00
        maybeButton.layer.borderColor = UIColor.black.cgColor
      
    }
    
    override func viewWillAppear(_ animated: Bool) {

        self.navigationItem.hidesBackButton = true
        
    }
    
    override func viewDidLayoutSubviews() {
    
        isLandscape = UIDevice.current.orientation.isLandscape
        
                if isLandscape {
        
                    buttonsStackView.axis = .horizontal
                    print("this worked")
                    
                    definitelyButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
                    definitelyNotButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
                    maybeButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
                    
                    questionLabel.widthAnchor.constraint(equalToConstant: 792).isActive = true
                    questionLabel.heightAnchor.constraint(equalToConstant: 164).isActive = true
                    
                } else {
                    
                    buttonsStackView.axis = .vertical
                    
                    definitelyButton.heightAnchor.constraint(equalToConstant: 58.5).isActive = true
                    definitelyNotButton.heightAnchor.constraint(equalToConstant: 58.5).isActive = true
                    maybeButton.heightAnchor.constraint(equalToConstant: 58.5).isActive = true
                    
                    questionLabel.widthAnchor.constraint(equalToConstant: 367).isActive = true
                    questionLabel.heightAnchor.constraint(equalToConstant: 391).isActive = true
                    
                }
        
}
    
    //MARK: - IBActions
    
    @IBAction func yesButton(_ sender: UIButton) {}
    
    @IBAction func noButton(_ sender: UIButton) {}

    @IBAction func answerPressed(_ sender: UIButton) {

        maybe.maybeCountFunc(buttonPressed: (sender.titleLabel?.text)!)
        
        questions?.nextQuestion()
        
        sender.backgroundColor = UIColor.green
        definitelyCount = answer.definitelyCountFunc(buttonPressed: (sender.titleLabel?.text)!)
        
        if (questions?.questionNumber ?? 0) == questions?.getQuizCount() {
            
            self.performSegue(withIdentifier: K.questionsResultsSeg, sender: self)
            answer.defToZero()
            maybe.maybeToZero()
            questions?.questionCountToZero()
            
        }

        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateFunc), userInfo: nil, repeats: false)
        
           }
    
//MARK: - Misc. Methods
    
    @objc func updateFunc() {

        questionLabel.text = questions?.getQuestionText()
        progressBar.progress = questions?.getProgress() ?? 0.0
        definitelyButton.backgroundColor = UIColor.white
        definitelyNotButton.backgroundColor = UIColor.white
        maybeButton.backgroundColor = UIColor.white
        
    }

    //MARK: - Segue Prep
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == K.questionsResultsSeg && maybe.maybeCount == 0 {
            
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.answerText = answer.getAnswerOption(maybePercentage: 1000)
            
        } else if segue.identifier == K.questionsResultsSeg && maybe.maybeCount >= ((questions?.getQuizCount())! / 2) {
            
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.answerText = " Sorry - you answered at least half of the questions with 'not sure'. Red Flags doesn't have enough data to accurately assess your partner. Come back when you have more intel. "
            
        } else if segue.identifier == K.questionsResultsSeg {
            
            let destinationVC = segue.destination as! ResultsViewController
            let maybeNumber = maybe.maybeCalculator(definitelyCount: definitelyCount, quizCount: (questions?.getQuizCount())!)
            destinationVC.answerText = answer.getAnswerOption(maybePercentage: maybeNumber)
            
        }

}
    
}
