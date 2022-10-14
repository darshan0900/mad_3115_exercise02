//
//  ViewController.swift
//  exercise02
//
//  Created by Darshan Jain on 2022-10-13.
//

import UIKit

class GameScreen: UIViewController {

	static let WINNING_SCORE = 5
	
	@IBOutlet weak var computerScore: UILabel!
	@IBOutlet weak var userScore: UILabel!
	
	@IBOutlet weak var computerDiceImage: UIImageView!
	@IBOutlet weak var userDiceImage: UIImageView!
	
	@IBOutlet weak var overlay: UIView!
	
	@IBOutlet weak var winningLabel: UILabel!{
		didSet{
			winningLabel.text = ""
		}
	}
	
	var user = Dice()
	var computer = Dice()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		resetGame()
	}

	@IBAction func onThrowDicePress(_ sender: Any) {
		let userDice = user.currentDice
		let computerDice = computer.currentDice
		
		
		userDiceImage.image = UIImage(named: "./dice\(userDice)")
		let userPoints = userDice - computerDice
		user.addScore(score: userPoints)
		userScore.text = "\(user.score)"
		
		
		computerDiceImage.image = UIImage(named: "./dice\(computerDice)")
		let computerPoints = computerDice - userDice
		computer.addScore(score: computerPoints)
		computerScore.text = "\(computer.score)"
		
		var winner = ""
		if(user.score>=GameScreen.WINNING_SCORE){
			winner = "You"
		}else if(computer.score>=GameScreen.WINNING_SCORE){
			winner="Computer"
		}
		if(winner.count>0){
			overlay.isHidden = false
			winningLabel.text = "\(winner) won the game."
			winningLabel.sizeToFit()
		}
		
	}
	
	@IBAction func onPlayAgainPress(_ sender: Any) {
		resetGame()
	}
	
	func resetGame () {
		let userDice = user.currentDice
		userDiceImage.image = UIImage(named: "./dice\(userDice)")
		user.resetScore()
		userScore.text="0"
		
		let computerDice = computer.currentDice
		computerDiceImage.image = UIImage(named: "./dice\(computerDice)")
		computer.resetScore()
		computerScore.text="0"
		
		overlay.isHidden = true
		winningLabel.text = ""
	}
}

