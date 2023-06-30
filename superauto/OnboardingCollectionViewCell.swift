//
//  OnboardingCollectionViewCell.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 13/02/2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideBigLabel: UILabel!
    @IBOutlet weak var slideSmarllLabel: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = UIImage(named: slide.image)
        slideBigLabel.text = slide.titile
        slideSmarllLabel.text = slide.description
    }
}
