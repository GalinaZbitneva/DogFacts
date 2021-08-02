//
//  TableViewCell.swift
//  getRandomCat
//
//  Created by Галина Збитнева on 30.07.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var factCatLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
