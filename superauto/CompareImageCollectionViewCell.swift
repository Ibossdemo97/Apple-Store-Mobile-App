//
//  CompareImageCollectionViewCell.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 07/12/2022.
//

import UIKit

class CompareImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCompare: UIImageView!
    @IBOutlet weak var view1: UIView!
    
    static func nib() -> UINib {
    return UINib(nibName: "CompareImageCollectionViewCell", bundle: nil)}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageCompare.frame.size = CGSize(width: view1.frame.width, height: view1.frame.width)
    }
    

}
