//
//  peopleCell.swift
//  Messenger
//
//  Created by admin on 12/28/22.
//

import UIKit

class peopleCell: UITableViewCell {

    @IBOutlet weak var friednImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    var cellID : Int = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
