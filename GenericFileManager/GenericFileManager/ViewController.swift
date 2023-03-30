//
//  ViewController.swift
//  GenericFileManager
//
//  Created by Oktay Tanrıkulu on 30.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func writeTapped(_ sender: Any) {
        let john = Person(name: "John Doe", age: 34)
        let jane = Person(name: "Jane Doe", age: 30)
        
        GenericFileManager.shared.write(to: "people", value: [john, jane]) { result in
            switch result {
            case .success(let success):
                if success {
                    print("People written to file.")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func readTapped(_ sender: Any) {
        
        GenericFileManager.shared.readJSON(from: "people") { [weak self] (result: Result<[Person], FileError>) in
            switch result {
            case .success(let people):
                self?.nameLabel.text = people.last!.name
                self?.ageLabel.text = "\(people.last!.age)"
            case .failure(let error):
                print(error)
            }
        }
    }
    

}

