//
//  ViewController.swift
//  exercise02
//
//  Created by Darshan Jain on 2022-10-13.
//

import UIKit

struct Score {
let userScore: Int
let computerScore: Int
}

class GameScreen: UIViewController, UITableViewDataSource {

	static let WINNING_SCORE = 20
	
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
	@IBOutlet weak var historyTable: UITableView!
	
	var user = Dice()
	var computer = Dice()
	var allScores: [Score] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		resetGame()
		
		historyTable.dataSource = self
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
			
			let gameCount = max(user.getScores().count, computer.getScores().count)
			
			var scores: [Score] = []
			
			for i in 0..<gameCount{
				scores.append(Score(
					userScore: user.getScore(index: i),
					computerScore:computer.getScore(index: i))
				)
			}
			allScores = scores
			historyTable.reloadData()
			historyTable.sizeToFit()
		}
		
	}
	
	@IBAction func onPlayAgainPress(_ sender: Any) {
		resetGame()
	}
	
	func resetGame () {
		allScores = []
		
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
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allScores.count + 2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = historyTable.dequeueReusableCell(withIdentifier: "gameScore") as! GameScore
		if(indexPath.row > allScores.count){
			cell.gameNo.text = "Total"
			cell.userScore.text = "\(user.score)"
			cell.computerScore.text = "\(computer.score)"
		} else if(indexPath.row > 0){
			let game = allScores[indexPath.row - 1]
			
			cell.gameNo.text = "\(indexPath.row)"
			cell.userScore.text = "\(game.userScore)"
			cell.computerScore.text = "\(game.computerScore)"
		}
		else {
			cell.gameNo.text = "Game No."
			cell.userScore.text = "You"
			cell.computerScore.text = "Computer"
		}
		return cell
	}
	
}

