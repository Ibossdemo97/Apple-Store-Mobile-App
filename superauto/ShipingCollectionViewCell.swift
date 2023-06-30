//
//  ShipingCollectionViewCell.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 28/02/2023.
//

import UIKit
import SDWebImage

var orderBillDetail = [OrderBill(orderNumber: String(), orderPrice: String(), intendTimeOD: String(), inforDetailOD: [String](),
                                orderDetail: OrderDetail(imageOD: [String](),              nameOD: [String](),
                                                         amountOD: [String](),             priceOD: [String]()))]
class ShipingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageOrder: UIImageView!
    @IBOutlet weak var nameOrder: UILabel!
    @IBOutlet weak var amountOrder: UILabel!
    @IBOutlet weak var priceOrder: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
struct OrderBill {
    var orderNumber = String()
    var orderPrice = String()
    var intendTimeOD = String()
    var inforDetailOD = [String]()
    var orderDetail = OrderDetail()
}
struct OrderDetail {
    var imageOD = [String]()
    var nameOD = [String]()
    var amountOD = [String]()
    var priceOD = [String]()
}
