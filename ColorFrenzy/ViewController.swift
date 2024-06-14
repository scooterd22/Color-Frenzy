//
//  ViewController.swift
//  ColorFrenzy
//
//  Created by Scott DiBenedetto on 4/30/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var targetColor: UILabel!
    @IBOutlet weak var startLabel: UIButton!
    @IBOutlet weak var mainButton: UIButton!
    
    var timer = Timer()
    var targetColorsArray = [UIColor.purple, UIColor.brown, UIColor.red, UIColor.green, UIColor.gray, UIColor.orange, UIColor.cyan]
    var score = 0
    var life = 3
    var gameOn = true
    var colorTimer = 0.75

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        lifeLabel.text = "Life: \(life)"
        mainButton.backgroundColor = targetColorsArray[Int.random(in: 0...(targetColorsArray.count - 1))]
        targetColor.backgroundColor = targetColorsArray[Int.random(in: 0...(targetColorsArray.count - 1))]
    }

    @IBAction func startPressed(_ sender: UIButton) {
        startTimer()
        startLabel.isHidden = true
        life = 3
        score = 0
        gameOn = true
        colorTimer = 0.75
        scoreLabel.text = "Score: \(score)"
        lifeLabel.text = "Life: \(life)"
        mainButton.backgroundColor = targetColorsArray[Int.random(in: 0...(targetColorsArray.count - 1))]
    }
    
    @IBAction func colorPressed(_ sender: UIButton) {
        timer.invalidate()
        checkColor()
        
    }
    
    func startTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: colorTimer, target: self, selector: #selector(changeColor), userInfo: nil, repeats: true)
    }
    
    @objc func changeColor() {
        targetColor.backgroundColor = targetColorsArray[Int.random(in: 0...(targetColorsArray.count - 1))]
    }
    func checkColor() {
        
        if targetColor.backgroundColor == mainButton.backgroundColor && gameOn == true {
            score += 1
            switch score {
            case 2:
                colorTimer -= 0.2
            case 4:
                colorTimer -= 0.1
            case 6:
                colorTimer -= 0.3
            default:
                colorTimer -= 0.0
            }
            scoreLabel.text = "Score: \(score)"
            let seconds = 3.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [self] in
                self.startTimer()
                self.mainButton.backgroundColor = self.targetColorsArray[Int.random(in: 0...(targetColorsArray.count - 1))]
            }
        } else {
            if life > 1 {
                life -= 1
                lifeLabel.text = "Life: \(life)"
                let seconds = 3.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.startTimer()
                    self.mainButton.backgroundColor = self.targetColorsArray[Int.random(in: 0...(self.targetColorsArray.count - 1))]
                }
                
            } else {
                lifeLabel.text = "Game Over"
                gameOn = false
                print(gameOn)
                startLabel.isHidden = false
                timer.invalidate()
                
                //mainButton.isEnabled = false
            }
            
        }
        
    }
    
}

