//
//  LoadingViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 21/02/2023.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createImageGIF()
        switchScreen()

    }
    func createImageGIF() {
        let imageGIF = UIImage.gifImageWithName("Rainbow square")
        let imageView = UIImageView(image: imageGIF)
        imageView.cornerRadius = 50
        imageView.frame = CGRect(x: view.center.x - 50, y: view.center.y - 50, width: 100, height: 100)
        view.addSubview(imageView)
    }
    func switchScreen() {
        if productsDetail.detailBasic.statusProducts.isEmpty == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "compares") as? ItemsNavigationController else { return }
                self.present(vc, animated: true, completion: nil)
            }
        } else {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "compares") as? ItemsNavigationController else { return }
            self.present(vc, animated: true, completion: nil)
        }
    }
}
