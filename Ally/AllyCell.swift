//
//  AllyCell.swift
//  Ally
//
//  Created by Rafa Moreno Cesar on 2/6/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit

class AllyCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
   
    @IBOutlet weak var pictureImage: UIImageView!

    
    @IBOutlet weak var emailLabel: UILabel!
         override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
