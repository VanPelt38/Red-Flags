//
//  WelcomeViewController.swift
//  Red Flags
//
//  Created by Jake Gordon on 31/01/2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //MARK: - Outlets & Properties
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var guyButton: UIButton!
    @IBOutlet weak var girlButton: UIButton!
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var barContainer: UIView!
    @IBOutlet weak var newStackView: UIStackView!
    
    private var questions: QuestionChoice? = nil
    private var isLandscape: Bool = false

    //MARK: - View Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        background.backgroundColor = UIColor(named: K.redBackColour)
        
        guyButton.layer.cornerRadius = 25
        guyButton.clipsToBounds = true
        guyButton.layer.borderWidth = 1.00
        guyButton.layer.borderColor = UIColor.black.cgColor
        guyButton.backgroundColor = UIColor(red: 0.51, green: 0.93, blue: 0.93, alpha: 1.00)
        
        girlButton.layer.cornerRadius = 25
        girlButton.clipsToBounds = true
        girlButton.layer.borderWidth = 1.00
        girlButton.layer.borderColor = UIColor.black.cgColor
        
        viewButton.layer.cornerRadius = 25
        viewButton.clipsToBounds = true
        viewButton.layer.borderWidth = 1.00
        viewButton.layer.borderColor = UIColor.black.cgColor
        
        barContainer.layer.borderWidth = 1.00
        barContainer.layer.borderColor = UIColor.black.cgColor
  
    }
    
    override func viewDidLayoutSubviews() {
    
        isLandscape = UIDevice.current.orientation.isLandscape
        
                if isLandscape {
        
                    newStackView.axis = .horizontal
                    newStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5).isActive = true
                    newStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 40).isActive = false
                    
                    barContainer.widthAnchor.constraint(equalToConstant: 896).isActive = true
                    barContainer.heightAnchor.constraint(equalToConstant: 65).isActive = true
                    
                    welcomeLabel.widthAnchor.constraint(equalToConstant: 833).isActive = true
                    welcomeLabel.heightAnchor.constraint(equalToConstant: 108).isActive = true
         
                } else {
                    
                    newStackView.axis = .vertical
                    newStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 40).isActive = true
               
                    barContainer.widthAnchor.constraint(equalToConstant: 414).isActive = true
                    barContainer.heightAnchor.constraint(equalToConstant: 65).isActive = true
                    
                    welcomeLabel.widthAnchor.constraint(equalToConstant: 375).isActive = true
                    welcomeLabel.heightAnchor.constraint(equalToConstant: 258).isActive = true
                    
                }
        
}
    
    //MARK: - IBActions
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {}
    
    @IBAction func savedButton(_ sender: UIButton) {}
    
    @IBAction func maleButton(_ sender: UIButton) {

        questions = MaleQuestions()
        
    }

    @IBAction func femaleButton(_ sender: UIButton) {

        questions = FemaleQuestions()
        
    }

   //MARK: - Segue Prep
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == K.maleQuestionsSeg || segue.identifier == K.femaleQuestionsSeg {
            
            let destinationVC = segue.destination as! QuestionsViewController
            destinationVC.questions = questions
            
        }
        
        }
    
}

