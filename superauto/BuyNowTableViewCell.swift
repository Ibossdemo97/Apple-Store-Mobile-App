//
//  BuyNowTableViewCell.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 27/12/2022.
//

import UIKit

class BuyNowTableViewCell: UITableViewCell {

    @IBOutlet weak var imageReview: UIImageView!
    @IBOutlet weak var nameReview: UILabel!
    @IBOutlet weak var amountReview: UILabel!
    @IBOutlet weak var priceReview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
