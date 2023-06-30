//
//  ProductViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 06/12/2022.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseFirestore

var child1 = String()
var child2 = String()

struct proNameAndImage {
    var name: [String]
    var imageName: [String]
}
var productsView = proNameAndImage(name: [String](), imageName: [String]())

var nameTitle = ""

class ProductViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableCate: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCate.dataSource = self
        tableCate.delegate = self
        
        nameLabel.text = "Tất cả sản phẩm \(nameTitle)"

    }
    func moveOnProductsDetal(index: Int) {
        child2 = productsView.name[index]
        loadDataProducts()
        if productsDetail.detailBasic.numberOfCmt.isEmpty == true {
            alertLoading()
        } else {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "compares") as? ItemsNavigationController else { return }
            self.present(vc, animated: true, completion: nil)
        }

    }
    func alertLoading() {
        let alertController = UIAlertController(title: nil, message: "Đang tải\n\n", preferredStyle: .alert)
        let spinnerIndicator = UIActivityIndicatorView(style: .large)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()

        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alertController.dismiss(animated: true, completion: nil)
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "compares") as? ItemsNavigationController else { return }
            self.present(vc, animated: true, completion: nil)
        }
    }
    func loadDataProducts() {
        var ref: DatabaseReference!
        ref = Database.database().reference().child("productsDetail")
        ref.child("\(child1)").child("\(child2)").child("detailBasic").observe(.value) { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else { return }
            let cost                = data["cost"]                  as? [Double] ?? [Double]()
            let heightImageOver     = data["heightImageOver"]       as? [Double] ?? [Double]()
            let heightImageSpecs    = data["heightImageSpecs"]      as? [Double] ?? [Double]()
            let widthImageOver      = data["widthImageOver"]        as? [Double] ?? [Double]()
            let widthImageSpecs     = data["widthImageSpecs"]       as? [Double] ?? [Double]()
            let ratting             = data["ratting"]               as? [Double] ?? [Double]()
            let imageCompare        = data["imageCompare"]          as? [String] ?? [String]()
            let imageOverView       = data["imageOverview"]         as? [String] ?? [String]()
            let imageSpecs          = data["imageSpecs"]            as? [String] ?? [String]()
            let modelName           = data["modelName"]             as? [String] ?? [String]()
            let specsTitle          = data["specsTitle"]            as? [String] ?? [String]()
            let statusProducts      = data["statusProducts"]        as? [String] ?? [String]()
            let numberImageAllColor = data["numberImageAllColor"]   as? [Int] ?? [Int]()
            let numberImagePerColor = data["numberImagePerColor"]   as? [Int] ?? [Int]()
            let numberOfCmt         = data["numberOfCmt"]           as? [Int] ?? [Int]()
            
            productsDetail.detailBasic.cost                 = cost
            productsDetail.detailBasic.heightImageOver      = heightImageOver
            productsDetail.detailBasic.heightImageSpecs     = heightImageSpecs
            productsDetail.detailBasic.widthImageOver       = widthImageOver
            productsDetail.detailBasic.widthImageSpecs      = widthImageSpecs
            productsDetail.detailBasic.ratting              = ratting
            productsDetail.detailBasic.imageCompare         = imageCompare
            productsDetail.detailBasic.imageOverview        = imageOverView
            productsDetail.detailBasic.imageSpecs           = imageSpecs
            productsDetail.detailBasic.modelName            = modelName
            productsDetail.detailBasic.specsTitle           = specsTitle
            productsDetail.detailBasic.statusProducts       = statusProducts
            productsDetail.detailBasic.numberImageAllColor  = numberImageAllColor
            productsDetail.detailBasic.numberImagePerColor  = numberImagePerColor
            productsDetail.detailBasic.numberOfCmt          = numberOfCmt
        }
        ref.child("\(child1)").child("\(child2)").child("imageProducts").observe(.value) { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else { return }
//            let list = ["imageProducts1", "imageProducts2", "imageProducts3", "imageProducts4", "imageProducts5", "imageProducts6"]
//            for i in list {
//                let i = data[i] as? [String] ?? ["0", "0"]
//            }
            let imageProducts1 = data["imageProducts1"] as? [String] ?? [String]()
            let imageProducts2 = data["imageProducts2"] as? [String] ?? [String]()
            let imageProducts3 = data["imageProducts3"] as? [String] ?? [String]()
            let imageProducts4 = data["imageProducts4"] as? [String] ?? [String]()
            let imageProducts5 = data["imageProducts5"] as? [String] ?? [String]()
            let imageProducts6 = data["imageProducts6"] as? [String] ?? [String]()
            productsDetail.imageProducts.imageProducts1 = imageProducts1
            productsDetail.imageProducts.imageProducts2 = imageProducts2
            productsDetail.imageProducts.imageProducts3 = imageProducts3
            productsDetail.imageProducts.imageProducts4 = imageProducts4
            productsDetail.imageProducts.imageProducts5 = imageProducts5
            productsDetail.imageProducts.imageProducts6 = imageProducts6
        }
        ref.child("\(child1)").child("\(child2)").child("tutorial").observe(.value) { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else { return }
            let tutorial1 = data["tutorial1"] as? [String] ?? [String]()
            let tutorial2 = data["tutorial2"] as? [String] ?? [String]()
            let tutorial3 = data["tutorial3"] as? [String] ?? [String]()
            let tutorial4 = data["tutorial4"] as? [String] ?? [String]()
            let tutorial5 = data["tutorial5"] as? [String] ?? [String]()
            let tutorial6 = data["tutorial6"] as? [String] ?? [String]()
            productsDetail.tutorial.tutorial1 = tutorial1
            productsDetail.tutorial.tutorial2 = tutorial2
            productsDetail.tutorial.tutorial3 = tutorial3
            productsDetail.tutorial.tutorial4 = tutorial4
            productsDetail.tutorial.tutorial5 = tutorial5
            productsDetail.tutorial.tutorial6 = tutorial6
        }
        let int = [0, 1, 2, 3, 4, 5]
        for i in int {
            ref.child("\(child1)").child("\(child2)").child("option1").child("\(i)").observe(.value) { (snapshot) in
                guard let option = snapshot.value as? [String: Any] else { return }
                productsDetail.option1[i].option = option["option"] as? [String] ?? [String]()
                productsDetail.option1[i].cost = option["cost"] as? [Double] ?? [Double]()
            }
            ref.child("\(child1)").child("\(child2)").child("option2").child("\(i)").observe(.value) { (snapshot) in
                guard let option = snapshot.value as? [String: Any] else { return }
                productsDetail.option2[i].option = option["option"] as? [String] ?? [String]()
                productsDetail.option2[i].cost = option["cost"] as? [Double] ?? [Double]()
            }
            ref.child("\(child1)").child("\(child2)").child("option3").child("\(i)").observe(.value) { (snapshot) in
                guard let option = snapshot.value as? [String: Any] else { return }
                productsDetail.option3[i].option = option["option"] as? [String] ?? [String]()
                productsDetail.option3[i].cost = option["cost"] as? [Double] ?? [Double]()
            }
            ref.child("\(child1)").child("\(child2)").child("option4").child("\(i)").observe(.value) { (snapshot) in
                guard let option = snapshot.value as? [String: Any] else { return }
                productsDetail.option4[i].option = option["option"] as? [String] ?? [String]()
                productsDetail.option4[i].cost = option["cost"] as? [Double] ?? [Double]()
            }
            ref.child("\(child1)").child("\(child2)").child("option5").child("\(i)").observe(.value) { (snapshot) in
                guard let option = snapshot.value as? [String: Any] else { return }
                productsDetail.option5[i].option = option["option"] as? [String] ?? [String]()
                productsDetail.option5[i].cost = option["cost"] as? [Double] ?? [Double]()
            }
            ref.child("\(child1)").child("\(child2)").child("option6").child("\(i)").observe(.value) { (snapshot) in
                guard let option = snapshot.value as? [String: Any] else { return }
                productsDetail.option6[i].option = option["option"] as? [String] ?? [String]()
                productsDetail.option6[i].cost = option["cost"] as? [Double] ?? [Double]()
            }
        }
    }
}
extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsView.name.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.width / 1.618 + 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCate.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductsTableViewCell
        cell.namesItems.text = productsView.name[indexPath.row]
        cell.imageBanner.sd_setImage(with: URL(string: productsView.imageName[indexPath.row]))
        cell.index = indexPath.row
        cell.onClickBuyClosure = { index in
            if let indexp = index {
                self.moveOnProductsDetal(index: indexp)
            }
        }
        return cell
    }
}
