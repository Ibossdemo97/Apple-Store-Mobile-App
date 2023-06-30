//
//  OverviewViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 29/11/2022.
//

import UIKit
import SDWebImage

var test: Int = 0

class OverviewViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rightButton = UIBarButtonItem(title: "Mua", style: .done, target: self, action: #selector(rightButtonPressed(_:)))
        self.navigationItem.rightBarButtonItems = [rightButton]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Trở về", style: .done, target: self, action: nil)
        
        title = "Tổng quan \(child2) \(productsDetail.detailBasic.modelName[test - 1])"
        let ratio = CGFloat((productsDetail.detailBasic.heightImageOver[test - 1] / productsDetail.detailBasic.widthImageOver[test - 1]))
//        let image1 = UIImage(named: productsDetail.detailBasic.imageOverview[test - 1])
//        let ratio: Double! = image1!.size.height / (image1?.size.width)!
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.width * CGFloat(ratio))
    }
        override func viewDidLayoutSubviews() {
//            let image1 = UIImage(named: productsDetail.detailBasic.imageOverview[test - 1])
            let ratio = CGFloat((productsDetail.detailBasic.heightImageOver[test - 1] / productsDetail.detailBasic.widthImageOver[test - 1]))
//            let ratio: Double! = image1!.size.height / (image1?.size.width)!
            let view1 = UIView()
            view1.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * ratio)
            view1.backgroundColor = .blue
            scrollView.addSubview(view1)
            
            let imageOver = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * CGFloat(ratio)))
            imageOver.backgroundColor = .brown
            imageOver.contentMode = .scaleAspectFit
            imageOver.sd_setImage(with: URL(string: productsDetail.detailBasic.imageOverview[test - 1]))
            view1.addSubview(imageOver)
        }
    @objc func rightButtonPressed(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "buy") as! BuyViewController
        navigationController?.show(vc, sender: nil)
    }
}

