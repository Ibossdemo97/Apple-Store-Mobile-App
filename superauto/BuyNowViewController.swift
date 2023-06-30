//
//  BuyNowViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 17/12/2022.
//

import UIKit
import SDWebImage
import FirebaseDatabase

var newOrder = NewOrder(newNameOD: [String](), newImageOD: [String](), newPriceOD: [Double](), newAmountOD: [Int]())
var priceTypes = [0.0, 1.0, 2.0, 3.0, 4.0]
var timeCurrent = ["hour": Int(), "minute": Int(), "day": Int(), "month": Int(), "year": Int()]
var intendTime = ["hour": Int(), "minute": Int(), "day": Int(), "month": Int(), "year": Int()]
var intendTimeFormat = String()
var timeCurrentFormat = String()
class BuyNowViewController: UIViewController {
    
    @IBOutlet weak var tableOrder: UITableView!
    @IBOutlet weak var receiverTF: UITextField!
    @IBOutlet weak var receiverPhoneTF: UITextField!
    @IBOutlet weak var receiverAddressTF: UITextField!
    @IBOutlet weak var receiverNoteTF: UITextField!
    @IBOutlet weak var billingInformationTV: UITextView!
    @IBOutlet weak var billingDetailTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CartViewController().takeTimeCurrent()
        
        tableOrder.dataSource = self
        tableOrder.delegate = self
        
        intendTimeFormat = "\(String(format: "%02d", intendTime["hour"]!)):\(String(format: "%02d", intendTime["minute"]!)) - \(String(format: "%02d", intendTime["day"]!))/\(String(format: "%02d", intendTime["month"]!))/\(String(format: "%04d", intendTime["year"]!))"
        timeCurrentFormat = "\(String(format: "%02d", intendTime["hour"]!)):\(String(format: "%02d", intendTime["minute"]!)) - \(String(format: "%02d", intendTime["day"]!))/\(String(format: "%02d", intendTime["month"]!))/\(String(format: "%04d", intendTime["year"]!))"
        setupBill()
    }
    override func viewDidAppear(_ animated: Bool) {
        tableOrder.reloadData()
    }
    func setupBill() {
        receiverTF.text = userData.name
        receiverPhoneTF.text = userData.sđt
        receiverAddressTF.text = userData.address
        receiverNoteTF.text = ""
            
        let sum = sumBill.reduce(0, +)
        priceTypes[0] = sum
        switch userData.rank {
        case "Mới":
            priceTypes[1] = sum * (1 - 0.00)
        case "Đồng":
            priceTypes[1] = sum * (1 - 0.02)
        case "Bạc":
            priceTypes[1] = sum * (1 - 0.04)
        case "Vàng":
            priceTypes[1] = sum * (1 - 0.06)
        case "Platium":
            priceTypes[1] = sum * (1 - 0.08)
        case "Kim cương":
            priceTypes[1] = sum * (1 - 0.10)
        default:
            priceTypes[1] = sum * 0
        }
        priceTypes[2] = sum - priceTypes[1]
//        if priceTypes[3] == nil {
//        } else {
            priceTypes[3] = 0.0
//        }
        priceTypes[4] = priceTypes[2] - priceTypes[3]
        billingInformationTV.text = "Dự kiến nhận hàng trước:\nTổng tiền:\nGiảm giá:\nPhải thanh toán:\nĐã thanh toán:\nCòn lại phải thanh toán:"
        billingDetailTV.text = "\(intendTimeFormat)\n\(priceTypes[0])00.000 Vnđ\n\(priceTypes[1])00.000 Vnđ\n\(priceTypes[2])00.000 Vnđ\n\(priceTypes[3])00.000 Vnđ\n\(priceTypes[4])00.000 Vnđ"
    }
    @IBAction func partialPayment(_ sender: UIButton) {
    }
    @IBAction func confirmBT(_ sender: UIButton) {
        if receiverTF.text?.isEmpty == false || receiverPhoneTF.text?.isEmpty == false || receiverAddressTF.text?.isEmpty == false {
            let ref = Database.database().reference()
            let newOrderRef = ref.child("userData").child("XVmwRw26FqeB7ZVqXvfSxTYj59v2").child("userData").child("newOrder")
            let newData = ["timeOrder": timeCurrentFormat,
                           "intendTime": intendTimeFormat,
                           "receiverDetail": [receiverTF.text! as String, receiverPhoneTF.text! as String, receiverAddressTF.text! as String, receiverNoteTF.text! as String],
                           "orderPrice": [priceTypes[0], priceTypes[1], priceTypes[2], priceTypes[3], priceTypes[4]],
                           "nameOD": newOrder.newNameOD,
                           "imageOD": newOrder.newImageOD,
                           "priceOD": newOrder.newPriceOD,
                           "amountOD": newOrder.newAmountOD] as [String : Any]
            newOrderRef.setValue(newData) { ( error, ref) in
                if let error = error {
                    let alert = UIAlertController(title: "Lỗi", message: "Tạo đơn hàng mới không thành công\nLỗi:\(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Chờ vài phút", style: .cancel))
                    self.present(alert, animated: true)
                    return
                }
                let alert = UIAlertController(title: "Thông báo", message: "Tạo đơn hàng mới thành công\nVui lòng chờ đơn hàng được kiểm tra và xác nhận", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel))
                self.present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng điền đầy đủ thông tin đơn hàng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel))
            self.present(alert, animated: true)
        }
    }
}
extension BuyNowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newOrder.newNameOD.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableOrder.dequeueReusableCell(withIdentifier: "BuyNowTableViewCell", for: indexPath) as? BuyNowTableViewCell {
            cell.nameReview.text = newOrder.newNameOD[indexPath.row]
            cell.imageReview.sd_setImage(with: URL(string: newOrder.newImageOD[indexPath.row]))
            cell.amountReview.text = "Số lượng: \(newOrder.newAmountOD[indexPath.row])"
            cell.priceReview.text = "Giá \(newOrder.newPriceOD[indexPath.row] * Double(newOrder.newAmountOD[indexPath.row]))00.000Vnđ"
            return cell
        }
        return UITableViewCell()
    }
}
struct NewOrder {
    var newNameOD = [String]()
    var newImageOD = [String]()
    var newPriceOD = [Double]()
    var newAmountOD = [Int]()
}
