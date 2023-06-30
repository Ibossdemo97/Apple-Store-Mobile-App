//
//  SpecsViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 29/11/2022.
//

import UIKit
import SDWebImage

class SpecsViewController: UIViewController {


    @IBOutlet weak var scrollView: UIScrollView!
    
    let imageSpec = UIImage(named: productsDetail.detailBasic.imageSpecs[test - 1])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Trở về", style: .done, target: self, action: nil)
        
        title = "Thông số kỹ thuật \(child2) \(productsDetail.detailBasic.modelName[test - 1])"
        let ratio = CGFloat((productsDetail.detailBasic.heightImageSpecs[test - 1] / productsDetail.detailBasic.widthImageSpecs[test - 1]))
//        let imageSpec = UIImage(named: productsDetail.detailBasic.imageSpecs[test - 1])
//        let ratio: Double! = imageSpec!.size.height / (imageSpec?.size.width)!
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.width * CGFloat(ratio))
    }
        override func viewDidLayoutSubviews() {
            let ratio = CGFloat((productsDetail.detailBasic.heightImageSpecs[test - 1] / productsDetail.detailBasic.widthImageSpecs[test - 1]))
//            let imageSpec = UIImage(named: productsDetail.detailBasic.imageSpecs[test - 1])
//            let ratio: Double! = imageSpec!.size.height / (imageSpec?.size.width)!
            let view1 = UIView()
            view1.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * ratio)
            view1.backgroundColor = .blue
            scrollView.addSubview(view1)
            
            let imageSpecs = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * CGFloat(ratio)))
            imageSpecs.backgroundColor = .brown
            imageSpecs.contentMode = .scaleAspectFit
            imageSpecs.sd_setImage(with: URL(string: productsDetail.detailBasic.imageSpecs[test - 1]))
            
            view1.addSubview(imageSpecs)
        }
}
