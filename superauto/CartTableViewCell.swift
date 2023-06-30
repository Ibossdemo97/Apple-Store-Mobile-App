//
//  CartTableViewCell.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 08/03/2023.
//

//
//  CartTableViewCell.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 27/12/2022.
//

import UIKit

typealias ChangeAmountClosure = ((_ index: Int?) -> Void)

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameAndOption: UILabel!
    @IBOutlet weak var priceAmount: UILabel!
    @IBOutlet weak var amountProduct: UILabel!
    @IBOutlet weak var selecAmountDown: UIButton!
    @IBOutlet weak var selecAmountUp: UIButton!
    @IBOutlet weak var imageProduct: UIImageView!
    
    var index: Int?
    var onClickToChangeAmountUp: ChangeAmountClosure?
    var onClickToChangeAmountDown: ChangeAmountClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func tapToPlus(_ sender: UIButton) {
        onClickToChangeAmountUp?(index)
    }
    @IBAction func tapToMinus(_ sender: UIButton) {
        onClickToChangeAmountDown?(index)
    }
}
