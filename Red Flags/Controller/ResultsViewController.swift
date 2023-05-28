//
//  ResultsViewController.swift
//  Red Flags
//
//  Created by Jake Gordon on 10/09/2022.
//

import UIKit


class ResultsViewController: UIViewController {
    
    //MARK: - Outlets & Properties
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var saveBut: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var retakeBut: UIButton!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    private var resultArray: [SavedResult] = []
    private var decodedData = [SavedResult]()
    private var isLandscape: Bool = false
    var answerText = "nothing"
    private let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(K.savedResultPlist)
    
    //MARK: - View Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        
        background.backgroundColor = UIColor(named: K.redBackColour)
        
        saveBut.layer.cornerRadius = 25
        saveBut.clipsToBounds = true
        saveBut.layer.borderWidth = 1.00
        saveBut.layer.borderColor = UIColor.black.cgColor
        
        retakeBut.layer.cornerRadius = 25
        retakeBut.clipsToBounds = true
        retakeBut.layer.borderWidth = 1.00
        retakeBut.layer.borderColor = UIColor.black.cgColor
        
        nameTextField.delegate = self
        nameTextField.attributedPlaceholder = NSAttributedString(string: " ...write your partner's name here! ", attributes: [NSAttributedString.Key.font : UIFont(name: K.Caveat, size: 20.0) as Any])
        nameTextField.font = UIFont(name: K.Caveat, size: 20.0)
        
        answerLabel.text = answerText
        
        self.view.addGestureRecognizer(tapGesture)
        loadCellName()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        self.navigationItem.hidesBackButton = true
        
    }
    
    override func viewDidLayoutSubviews() {
    
        isLandscape = UIDevice.current.orientation.isLandscape
        
                if isLandscape {
        
                    bottomStackView.axis = .horizontal
                    
                    answerLabel.widthAnchor.constraint(equalToConstant: 752).isActive = true
                    answerLabel.heightAnchor.constraint(equalToConstant: 123).isActive = true
                    
                } else {
                    
                    bottomStackView.axis = .vertical
                    
                    answerLabel.widthAnchor.constraint(equalToConstant: 398).isActive = true
                    answerLabel.heightAnchor.constraint(equalToConstant: 328).isActive = true
                    
                }
        
}
    
    //MARK: - IBActions
    
    @IBAction func saveQuizButton(_ sender: UIButton) {
        
        if let safeFieldText = nameTextField.text {
            
            if safeFieldText == "" {
                
                let noTextAlert = UIAlertController(title: "Type Something!", message: "You need to actually type a name, in order to save it.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Okay", style: .default)
                noTextAlert.addAction(okayAction)
                present(noTextAlert, animated: true, completion: nil)
                
            } else if resultArray.count < 20 {
                
                if let resultMessage = answerLabel.text {
                    
                    let savedUser = SavedResult(name: safeFieldText, resultMessage: resultMessage)
                    resultArray.append(savedUser)
                    let encoder = PropertyListEncoder()
                    if let safeFilePath = filePath {
                        do {
                            
                            let data = try encoder.encode(resultArray)
                            try data.write(to: safeFilePath)
                            
                        } catch {
                            
                            print("There was an error saving data: \(error)")
                            
                        }
                    }
                    
                }
                
                let savedAlert = UIAlertController(title: "Success!", message: "Your Result Has Been Saved.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Okay", style: .default)
                savedAlert.addAction(okayAction)
                present(savedAlert, animated: true, completion: nil)
                
                nameTextField.text = ""
                
            } else {
                
                let alert = UIAlertController(title: "Too Many Saved Results!", message: "Sorry, you can save 20 quiz results max. To save more, please delete some first.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Okay", style: .default)
                alert.addAction(okayAction)
                present(alert, animated: true, completion: nil)
                
            }
            
        }
                        
                        }
    
    @IBAction func retakeQuizButton(_ sender: UIButton) {}
    
    //MARK: - Misc. Methods
    
    func loadCellName() {
        
        resultArray = [ ]
        
        if let safeFilePath = filePath {
            
            if let data = try? Data(contentsOf: safeFilePath) {
                
                let decoder = PropertyListDecoder()
                do {
                    
                    decodedData = try decoder.decode([SavedResult].self, from: data)
                    
                } catch {
                    
                    print("There was an error loading data: \(error)")
                    
                }
                
            }
            
        }
        
        resultArray = decodedData
        
    }
    
}

//MARK: - UITextFieldDelegate

extension ResultsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        nameTextField.endEditing(true)
        return true
        
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        
        nameTextField.resignFirstResponder()
        nameTextField.endEditing(true)
        
    }
    
}
