//
//  GameScore.swift
//  exercise02
//
//  Created by Darshan Jain on 2022-10-14.
//

import UIKit

class GameScore: UITableViewCell {

	@IBOutlet weak var gameNo: UILabel!
	
	@IBOutlet weak var userScore: UILabel!
	
	@IBOutlet weak var computerScore: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
