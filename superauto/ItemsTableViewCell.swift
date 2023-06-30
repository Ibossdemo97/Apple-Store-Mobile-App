//
//  ItemsTableViewCell.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 06/12/2022.
//

import UIKit
import SDWebImage

typealias ViewAllClosure = ((_ index: Int?) -> Void)

class ItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var namesItems: UILabel!
    @IBOutlet weak var showAll: UIButton!
    
    var index: Int?
    var onClickViewAllClosure: ViewAllClosure?
//    internal var cellDelegate: tableViewNew?
//    internal var index: IndexPath?
    
//    static func nib() -> UINib {
//    return UINib(nibName: "ItemsTableViewCell", bundle: nil)}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageCollection.delegate = self
        imageCollection.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func clickToViewAll(_ sender: Any) {
        onClickViewAllClosure?(index)
    }
}
extension ItemsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollection.frame.width, height: imageCollection.frame.width / 1.618)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImage[imageCollection.tag].image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "ItemsCollectionCell", for: indexPath) as! ItemsCollectionViewCell
        cell.imageBanner.sd_setImage(with: URL(string: listImage[imageCollection.tag].image[indexPath.row]))
        return cell
    }


}
