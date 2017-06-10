//
//  DetailTableViewCell.swift
//  Pro Search for iTune
//
//  Created by surendra kumar on 2/20/17.
//  Copyright © 2017 weza. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet var value: UILabel!
    @IBOutlet var field: UILabel!
    override func awakeFromNib() {
       
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
