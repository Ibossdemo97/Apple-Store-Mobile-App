//
//  ProductsTableViewCell.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 06/12/2022.
//

import UIKit

typealias BuyClosure = ((_ index: Int?) -> Void)

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var namesItems: UILabel!
    @IBOutlet weak var showAll: UIButton!

    var index: Int?
    var onClickBuyClosure: BuyClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showAll.layer.cornerRadius = 17
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func clickToBuy(_ sender: Any) {
        onClickBuyClosure?(index)
    }
}
