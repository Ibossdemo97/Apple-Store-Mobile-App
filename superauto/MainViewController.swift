//
//  MainViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 23/12/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

var listItem = ["Mac", "iPad", "iPhone", "Watch", "AirPods", "TV & Nhà ở", "Phụ kiện"]
var listPro = [ModelProducts(name: "Mac", pro: [String]()),
               ModelProducts(name: "iPad", pro: [String]()),
               ModelProducts(name: "iPhone", pro: [String]()),
               ModelProducts(name: "Watch", pro: [String]()),
               ModelProducts(name: "AirPods", pro: [String]()),
               ModelProducts(name: "TV & Nhà ở", pro: [String]()),
               ModelProducts(name: "Phụ kiện", pro: [String]())
                ]
var listImage = [ModelImage(products: "Mac", image: [String]()),
                 ModelImage(products: "iPad", image: [String]()),
                 ModelImage(products: "iPhone", image: [String]()),
                 ModelImage(products: "Watch", image: [String]()),
                 ModelImage(products: "AirPods", image: [String]()),
                 ModelImage(products: "TV & Nhà ở", image: [String]()),
                 ModelImage(products: "Phụ kiện", image: [String]())
                ]
var listOrder = [String]()

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataUser()
        NewsViewController().takeDataNews()

        
    }
    func getDataUser() {
        if Auth.auth().currentUser != nil {
            var ref: DatabaseReference!
            ref = Database.database().reference().child("userData").child("XVmwRw26FqeB7ZVqXvfSxTYj59v2").child("userData")
            ref.child("yourOrder").observe(.value) { (snapshot) in
                guard let data = snapshot.value as? [String: Any] else { return }
                listOrder = data.keys.map { $0 }
                for i in listOrder {
                    ref.child("yourOrder").child("\(i)").observe(.value) { (snapshot, _) in
                        guard let data = snapshot.value as? [String: Any] else { return }
                        let imageOD = data["imageOD"] as? [String] ?? [String]()
                        let nameOD = data["nameOD"] as? [String] ?? [String]()
                        let amountOD = data["amountOD"] as? [String] ?? [String]()
                        let priceOD = data["priceOD"] as? [String] ?? [String]()
                        let inforDetailOD = data["inforDetailOD"] as? [String] ?? [String]()
                        let priceBill = data["priceBill"] as? String ?? String()
                        let intendTime = data["intendTime"] as? String ?? String()
                        
                        orderBillDetail[listOrder.firstIndex(of: "\(i)")!].orderNumber = i
                        orderBillDetail[listOrder.firstIndex(of: "\(i)")!].orderPrice = priceBill
                        orderBillDetail[listOrder.firstIndex(of: "\(i)")!].inforDetailOD = inforDetailOD
                        orderBillDetail[listOrder.firstIndex(of: "\(i)")!].intendTimeOD = intendTime
                        orderBillDetail[listOrder.firstIndex(of: "\(i)")!].orderDetail.imageOD = imageOD
                        orderBillDetail[listOrder.firstIndex(of: "\(i)")!].orderDetail.nameOD = nameOD
                        orderBillDetail[listOrder.firstIndex(of: "\(i)")!].orderDetail.amountOD = amountOD
                        orderBillDetail[listOrder.firstIndex(of: "\(i)")!].orderDetail.priceOD = priceOD
                    }
                }
            }
        } else {
        }
    }
}

struct ModelProducts {
    var name: String
    var pro: [String]
}
struct ModelImage {
    var products: String
    var image: [String]
}
