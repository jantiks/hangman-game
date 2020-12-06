//
//  ViewController.swift
//  hangman game
//
//  Created by Tigran on 12/6/20.
//  Copyright © 2020 Tigran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var tries = 0
    var words = ["HELLO", "GREEN", "SWIFT", "APPLE", "VALLEY"]
    var wordLetters = [String]()
    var usedLetters = [String]()
    var labelStrArr = [String]()
    var labelStr = "" {
        didSet {
            wordLabel.text = labelStr
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        startGame()
        
        
        
        
    }
    
    func startGame() {
        usedLetters.removeAll(keepingCapacity: true)
        wordLetters.removeAll(keepingCapacity: true)
        labelStrArr.removeAll(keepingCapacity: true)
        
        words.shuffle()

        let choosedWord = words[0]
        
        for letter in choosedWord {
            labelStrArr.append("?")
            wordLetters.append(String(letter))
        }
        
        labelStr = labelStrArr.joined()
    }

    @IBAction func submitTapped(_ sender: UIButton) {
        if let typedLetter = textField.text {
            if usedLetters.contains(typedLetter.lowercased()){
                let ac = UIAlertController(title: "this letter is used", message: "try another one", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(ac,animated: true)
            }
            for (index, letter) in wordLetters.enumerated() {
                if typedLetter.lowercased() == letter.lowercased(){
                    labelStrArr.remove(at: index)
                    labelStrArr.insert(letter, at: index)
                    labelStr = labelStrArr.joined()

                    usedLetters.append(letter.lowercased())
                    
                    textField.text = ""
                }
            }
        }else {
            let ac = UIAlertController(title: "wrong letter", message: "try another one", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default , handler: nil))
            present(ac,animated: true)
            if tries == 7 {
                //code will be here
            }
            tries += 1
            
        }
    }
    
}

