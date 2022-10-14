//
//  Dice.swift
//  exercise02
//
//  Created by Darshan Jain on 2022-10-13.
//

import Foundation

class Dice {
	
	private var scores: [Int] = []
	
	var score: Int {
		return scores.reduce(0, {$0 + $1})
	}
	
	var currentDice: Int {
		return Int.random(in: 1...6)
	}
	
	func addScore(score: Int) {
		scores.append(score)
	}
	
	func resetScore() {
		scores.removeAll()
	}
	
}
