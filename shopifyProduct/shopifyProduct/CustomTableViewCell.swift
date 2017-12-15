//
//  CustomTableViewCell.swift
//  shopifyProduct
//
//  Created by Tianyi Zhang on 2017-12-15.
//  Copyright © 2017 Tianyi Zhang. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    

    
    @IBOutlet weak var cellView: CustomTableViewCell!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
