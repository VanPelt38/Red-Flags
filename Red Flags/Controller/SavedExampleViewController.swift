//
//  SavedExampleViewController.swift
//  Red Flags
//
//  Created by Jake Gordon on 07/10/2022.
//

import UIKit


class SavedExampleViewController: UIViewController {
    
    //MARK: - Outlets & Properties
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var resultText = "none"
    private var isLandscape: Bool = false
    
    //MARK: - View Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.backgroundColor = UIColor(named: K.redBackColour)
        
        resultLabel.text = resultText
        
    }
    
    override func viewDidLayoutSubviews() {
        
        isLandscape = UIDevice.current.orientation.isLandscape
        
        if isLandscape {
            
            resultLabel.widthAnchor.constraint(equalToConstant: 778).isActive = true
            resultLabel.heightAnchor.constraint(equalToConstant: 317).isActive = true
            
        } else {
            
            resultLabel.widthAnchor.constraint(equalToConstant: 289).isActive = true
            resultLabel.heightAnchor.constraint(equalToConstant: 669).isActive = true
            
        }
        
    }

}
