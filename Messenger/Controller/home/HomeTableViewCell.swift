//
//  HomeTableViewCell.swift
//  Messenger
//
//  Created by Munira on 28/12/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var conversationLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var conversationImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
