//
//  SavedViewController.swift
//  Red Flags
//
//  Created by Jake Gordon on 07/10/2022.
//

import UIKit


class SavedViewController: UIViewController {
    
    //MARK: - Outlets & Properties
    
    @IBOutlet var background: UIView!
    @IBOutlet weak var resultsTableView: UITableView!
    
    private let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(K.savedResultPlist)
    private let blueCell = UIColor(red: 0.51, green: 0.93, blue: 0.93, alpha: 1.00)
    private let yellowCell = UIColor(red: 1.00, green: 0.92, blue: 0.65, alpha: 1.00)
    private let purpleCell = UIColor(red: 0.64, green: 0.61, blue: 1.00, alpha: 1.00)
    private var resultArray: [SavedResult] = []
    private var decodedData = [SavedResult]()
    private var resultLabel = "none"
    
    //MARK: - View Setup

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTableView.backgroundColor = UIColor(named: K.redBackColour)
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.rowHeight = 80.0
        
        loadCellName()
        
    }
    
    //MARK: - Misc. Methods
    
    func loadCellName() {
        
        resultArray = []
        
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
        self.resultsTableView.reloadData()
        
    }
    
    //MARK: - Segue Prep
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == K.savedExamSeg {
            
            let destinationVC = segue.destination as! SavedExampleViewController
            destinationVC.resultText = resultLabel
            
        }
        
        }
    
}

//MARK: - UITableViewDataSource
    
extension SavedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if resultArray.count == 0 {
            
            return 1
            
        } else {
            
            return resultArray.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: K.resultCell, for: indexPath)
        
        cell.textLabel?.textColor = .black
        cell.overrideUserInterfaceStyle = .light

        if resultArray.count == 0 {

            cell.textLabel?.text = "No Saved Results Yet."
            cell.textLabel?.attributedText = NSAttributedString(string: (cell.textLabel?.text)!, attributes: [NSAttributedString.Key.font : UIFont(name: K.Caveat, size: 30.0) as Any])
            cell.backgroundColor = blueCell
            cell.accessoryType = .none
            cell.isUserInteractionEnabled = false
            return cell
            
        } else {
            
            cell.textLabel?.text = resultArray[indexPath.row].name
            cell.textLabel?.attributedText = NSAttributedString(string: (cell.textLabel?.text)!, attributes: [NSAttributedString.Key.font : UIFont(name: K.Caveat, size: 30.0) as Any])
            switch indexPath.row {
                
            case 0, 3, 6, 9, 12, 15, 18, 21, 24, 27:
                cell.backgroundColor = blueCell
            case 1, 4, 7, 10, 13, 16, 19, 22, 25:
                cell.backgroundColor = yellowCell
            case 2, 5, 8, 11, 14, 17, 20, 23:
                cell.backgroundColor = purpleCell
            default:
                fatalError("cell background colour setting failed.")
                
            }
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
           
            resultArray.remove(at: indexPath.row)
            let encoder = PropertyListEncoder()
            
            if let safeFilePath = self.filePath {
                
                do {
                    
                    let data = try encoder.encode(self.resultArray)
                    try data.write(to: safeFilePath)
                    
                } catch {
                    
                    print("There was an error saving data: \(error)")
                    
                }
                
            }
            
            if indexPath.row == 0 && resultArray.count == 0 {
                
                if let cell = resultsTableView.cellForRow(at: indexPath) {
                    
                    cell.textLabel?.text = "No Saved Results Yet."
                    cell.textLabel?.attributedText = NSAttributedString(string: (cell.textLabel?.text)!, attributes: [NSAttributedString.Key.font : UIFont(name: K.Caveat, size: 30.0) as Any])
                    cell.backgroundColor = blueCell
                    cell.accessoryType = .none
                    resultsTableView.isUserInteractionEnabled = false
                    
                }
                
            } else {
 
                    resultsTableView.deleteRows(at: [indexPath], with: .fade)
                
                }
  
            }
 
        }
    
    }

   //MARK: - UITableViewDelegate

extension SavedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if resultArray.count != 0 {
            
            resultLabel = resultArray[indexPath.row].resultMessage
            resultsTableView.deselectRow(at: indexPath, animated: true)
            self.performSegue(withIdentifier: K.savedExamSeg, sender: self)
            
        } else {
            
            resultsTableView.deselectRow(at: indexPath, animated: true)
            
        }
    
}
    
}

