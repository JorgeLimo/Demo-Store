//
//  ItemCarritoTableViewCell.swift
//  Demo Store
//
//  Created by Jorge Luis Limo Arispe on 25/04/17.
//  Copyright © 2017 Jorge Luis Limo. All rights reserved.
//

import UIKit

class ItemCarritoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgItem: UIImageView!
    
    @IBOutlet weak var nomItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
