//
//  ViewController.swift
//  hangman game
//
//  Created by Tigran on 12/6/20.
//  Copyright © 2020 Tigran. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
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

        textField.delegate = self
        
        
        startGame()
        
        
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= 1
    }
    
    
    func startGame() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            self?.usedLetters.removeAll(keepingCapacity: true)
            self?.wordLetters.removeAll(keepingCapacity: true)
            self?.labelStrArr.removeAll(keepingCapacity: true)
            self?.tries = 0
            
            self?.words.shuffle()
            
            let choosedWord = self?.words[0]
            
            for letter in choosedWord! {
                self?.labelStrArr.append("?")
                self?.wordLetters.append(String(letter))
            }
        }
        DispatchQueue.main.async {
            [weak self] in
            self?.labelStr = (self?.labelStrArr.joined())!

        }
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
        
        if let typedLetter = textField.text {
            if usedLetters.contains(typedLetter.lowercased()){
                let ac = UIAlertController(title: "this letter is used", message: "try another one", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(ac,animated: true)
            }
            
            if wordLetters.contains(typedLetter.uppercased()){
                for (index, letter) in wordLetters.enumerated() {
                    if typedLetter.lowercased() == letter.lowercased(){
                        labelStrArr.remove(at: index)
                        labelStrArr.insert(letter, at: index)
                        labelStr = labelStrArr.joined()
                        
                        usedLetters.append(letter.lowercased())
                        
                        textField.text = ""
                    }
                }
                
                if !labelStrArr.contains("?") {
                    let ac = UIAlertController(title: "Congrats you won", message: nil, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(ac,animated: true)
                    startGame()
                }
                
            }else {
                tries += 1

                textField.text = ""
                let ac = UIAlertController(title: "wrong letter", message: "you made \(tries) mistake", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default , handler: nil))
                present(ac,animated: true)
                
                if tries == 7 {
                    startGame()
                }
                
                
                
            }
            
            
        }
            
    }
}
    


