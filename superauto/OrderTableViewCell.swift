//
//  OrderTableViewCell.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 02/03/2023.
//

import UIKit

class OrderTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var collecOrder: UICollectionView!
    @IBOutlet weak var titleDetailTV: UITextView!
    @IBOutlet weak var inforDetailTV: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleDetailTV.text = "Dự kiến nhận hàng lúc:\nTình trạng đơn hàng:\n\nNgười nhận:\nSđt người nhận\nĐịa chỉ:\nGhi chú:"
        collecOrder.delegate = self
        collecOrder.dataSource = self
        let nib = UINib(nibName: "ShipingCollectionViewCell", bundle: nil)
        self.collecOrder.register(nib, forCellWithReuseIdentifier: "ShipingCollectionViewCell")
        
        if orderBillDetail.isEmpty == true {
            orderNumber.isHidden = true
            orderPrice.isHidden = true
            collecOrder.isHidden = true
        } else {
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collecOrder.frame.width, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderBillDetail[collecOrder.tag].orderDetail.nameOD.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShipingCollectionViewCell", for: indexPath) as! ShipingCollectionViewCell
        cell.imageOrder.sd_setImage(with: URL(string: orderBillDetail[collecOrder.tag].orderDetail.imageOD[indexPath.row]))
        cell.nameOrder.text = orderBillDetail[collecOrder.tag].orderDetail.nameOD[indexPath.row]
        cell.amountOrder.text = "Số lượng: \(orderBillDetail[collecOrder.tag].orderDetail.amountOD[indexPath.row])"
        cell.priceOrder.text = "Đơn giá: \(orderBillDetail[collecOrder.tag].orderDetail.priceOD[indexPath.row])00.000 Vnđ"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
