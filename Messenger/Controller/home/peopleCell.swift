//
//  peopleCell.swift
//  Messenger
//
//  Created by admin on 12/28/22.
//

import UIKit

class peopleCell: UITableViewCell {

    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    var userName = String()
    var cellID : Int = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        friendName.text = userName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
