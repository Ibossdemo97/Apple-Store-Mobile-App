//
//  CartViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 17/12/2022.
//

import UIKit
import SDWebImage
import FirebaseAuth

var sumBill = [Double]()

class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTable: UITableView!
    @IBOutlet weak var planLB: UILabel!
    @IBOutlet weak var planBillLB: UILabel!
    @IBOutlet weak var contactBT: UIButton!
    @IBOutlet weak var paymentBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEmptyCart()
        
        if Auth.auth().currentUser != nil && userData.cart.items.isEmpty != true {
            for _ in 1...userData.cart.items.count {
                if sumBill.count >= userData.cart.items.count {
                } else {
                    sumBill.append(0)
                }
            }
        } else { }
        cartTable.dataSource = self
        cartTable.delegate = self
        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        cartTable.register(nib, forCellReuseIdentifier: "CartTableViewCell")
        
        cartTable.reloadData()
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            swipeDown.direction = .down
            view.addGestureRecognizer(swipeDown)
    }
    override func viewWillAppear(_ animated: Bool) {
        setupEmptyCart()
        LoginViewController().getDataForCart()

    }
    @objc func handleSwipe(_ gestureRecognizer: UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            self.loadView()
            self.viewDidLoad()
        }
    }
    func setupEmptyCart() {
        let imageEmpty = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        imageEmpty.contentMode = .scaleAspectFit
        imageEmpty.center = view.center
        imageEmpty.image = UIImage(named: "empty_cart")
        cartTable.reloadData()
        
        if Auth.auth().currentUser == nil {
            let alert = UIAlertController(title: "Thông báo", message: "Đăng nhập để dược hỗ trợ tốt nhất", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Bỏ qua", style: .default) { _ in
            }
            let okAction = UIAlertAction(title: "Đăng nhập", style: .default, handler: { _ in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccViewController") as! AccViewController
                self.present(vc, animated: true)
            })
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else { }
        if userData.cart.items.isEmpty == true {
            contactBT.isHidden = true
            paymentBT.isHidden = true
            planLB.isHidden = true
            planBillLB.isHidden = true
            view.addSubview(imageEmpty)
        } else {
            contactBT.isHidden = false
            paymentBT.isHidden = false
            planLB.isHidden = false
            planBillLB.isHidden = false
//            imageEmpty.isHidden = false
//            imageEmpty.image = UIImage(named: "")
//            view.addSubview(imageEmpty)
        }
    }
    func changeAmountDown(index: Int) {
        if userData.cart.soLuong[index] == 0 {
            userData.cart.soLuong.remove(at: index)
            userData.cart.price.remove(at: index)
            userData.cart.items.remove(at: index)
            userData.cart.image.remove(at: index)
            sumBill.remove(at: index)
        } else {
            userData.cart.soLuong.insert(userData.cart.soLuong[index] - 1, at: index)
            userData.cart.soLuong.remove(at: index + 1)
            sumBill.insert(userData.cart.price[index] * Double(userData.cart.soLuong[index]), at: index)
            sumBill.remove(at: index + 1)
        }
        self.viewDidLoad()
        cartTable.reloadData()    }
    func changeAmountUp(index: Int) {
        if userData.cart.soLuong[index] == 99 {
            let alert = UIAlertController(title: "Thông báo", message: "Đã đạt số lượng có thể mua tối đa", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(alert, animated: true)
        } else {
            userData.cart.soLuong.insert(userData.cart.soLuong[index] + 1, at: index)
            userData.cart.soLuong.remove(at: index + 1)
            sumBill.insert(userData.cart.price[index] * Double(userData.cart.soLuong[index]), at: index)
            sumBill.remove(at: index + 1)
        }
        cartTable.reloadData()
    }
    @IBAction func tapToPaymenBT(_ sender: UIButton) {
        takeTimeCurrent()
            let indexNeedRemove = userData.cart.soLuong.indexes(of: 0)
            for i in indexNeedRemove.sorted().reversed() {
                userData.cart.soLuong.remove(at: i)
            }
            for i in userData.cart.soLuong {
                for _ in 1...userData.cart.soLuong.count {
                    if newOrder.newAmountOD.count >= userData.cart.soLuong.count {
                    } else {
                        newOrder.newAmountOD.append(0)
                        newOrder.newNameOD.append("0")
                        newOrder.newPriceOD.append(0)
                        newOrder.newImageOD.append("0")
                    }
                }
                newOrder.newNameOD[userData.cart.soLuong.firstIndex(of: i)!] = userData.cart.items[userData.cart.soLuong.firstIndex(of: i)!]
                newOrder.newImageOD[userData.cart.soLuong.firstIndex(of: i)!] = userData.cart.image[userData.cart.soLuong.firstIndex(of: i)!]
                newOrder.newPriceOD[userData.cart.soLuong.firstIndex(of: i)!] = userData.cart.price[userData.cart.soLuong.firstIndex(of: i)!]
                newOrder.newAmountOD[userData.cart.soLuong.firstIndex(of: i)!] = userData.cart.soLuong[userData.cart.soLuong.firstIndex(of: i)!]
            }
            if newOrder.newAmountOD.isEmpty == false {
                let vc = (storyboard?.instantiateViewController(withIdentifier: "BuyNowViewController") as? BuyNowViewController)!
                present(vc, animated: true)
            } else {
                let alert = UIAlertController(title: "Bạn không định mua gì sao?", message: "Không có sản phẩm nào trong đơn hàng", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alert, animated: true)
            }
        }
//    }
    @IBAction func tapToContactBT(_ sender: UIButton) {
    }
    func takeTimeCurrent() {
        let now = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.dateFormat = "HH:mm:ss dd/MM/yyyy"
        let dateString = formatter.string(from: now)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let day = calendar.component(.day, from: now)
        let month = calendar.component(.month, from: now)
        let year = calendar.component(.year, from: now)
        if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 {
            intendTime["year"] = year
            if day >= 1 && day < 31 {
                intendTime["day"] = day + 1
                intendTime["month"] = month
            } else if day == 31 {
                intendTime["day"] = 1
                intendTime["month"] = month + 1
            }
        } else if month == 4 || month == 6 || month == 9 || month == 11 {
            intendTime["year"] = year
            if day >= 1 && day < 30 {
                intendTime["day"] = day + 1
                intendTime["month"] = month
            } else if day == 30 {
                intendTime["day"] = 1
                intendTime["month"] = month + 1
            }
        } else if month == 12 {
            if day >= 1 && day < 31 {
                intendTime["day"] = day + 1
                intendTime["month"] = month
            } else if day == 31 {
                intendTime["day"] = 1
                intendTime["month"] = 1
                intendTime["year"] = year + 1
            }
        } else if month == 2 {
            if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 { // Năm nhuận
                intendTime["year"] = year
                if day >= 1 && day < 29 {
                    intendTime["day"] = day + 1
                    intendTime["month"] = month
                } else if day == 29 {
                    intendTime["day"] = 1
                    intendTime["month"] = month + 1
                }
            } else {
                intendTime["year"] = year
                if day >= 1 && day < 28 {
                    intendTime["day"] = day + 1
                    intendTime["month"] = month
                } else if day == 28 {
                    intendTime["day"] = 1
                    intendTime["month"] = month + 1
                }
            }
        }
        if minute >= 0 && minute < 30 {
            intendTime["minute"] = minute
            if hour >= 0 && hour < 8 {
                intendTime["hour"] = 10
            } else if hour >= 8 && hour < 18 {
                intendTime["hour"] = hour + 2 // Giờ + 2
            } else if hour >= 18 && hour < 24 {
                intendTime["hour"] = 10
            }
        } else if minute >= 30 && minute < 59 {
            intendTime["minute"] = 00
            if hour >= 0 && hour < 8 {
                intendTime["hour"] = 10
            } else if hour >= 8 && hour < 18 {
                intendTime["hour"] = hour + 3 // Giờ + 3
            } else if hour >= 18 && hour < 24 {
                intendTime["hour"] = 10
            }
        }
    }
}
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.cart.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sum = sumBill.reduce(0, +)
        self.planBillLB.text = "\(sum)00.000Vnđ"
        let cell = cartTable.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        cell.nameAndOption.text = userData.cart.items[indexPath.row]
        cell.priceAmount.text = "\(Double(userData.cart.price[indexPath.row] * Double(userData.cart.soLuong[indexPath.row])))00.000Vnđ"
//        cell.priceAmount.text = "\(userData.cart.price[indexPath.row])00.000Vnđ"
        cell.imageProduct.sd_setImage(with: URL(string: userData.cart.image[indexPath.row]))
        cell.amountProduct.text = String(userData.cart.soLuong[indexPath.row])
        cell.index = indexPath.row
        cell.onClickToChangeAmountUp = { index in
            if let indexp = index {
                self.changeAmountUp(index: indexp)
                sumBill.insert(Double(userData.cart.price[indexPath.row] * Double(userData.cart.soLuong[indexPath.row])), at: indexPath.row)
                sumBill.remove(at: indexPath.row + 1)
                self.planBillLB.text = "\(sum)00,000Vnđ"
            }
        }
        cell.onClickToChangeAmountDown = { index in
            if let indexp = index {
                self.changeAmountDown(index: indexp)
                sumBill.insert(Double(userData.cart.price[indexPath.row] * Double(userData.cart.soLuong[indexPath.row])), at: indexPath.row)
                sumBill.remove(at: indexPath.row + 1)
                self.planBillLB.text = "\(sum)00.000Vnđ"
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cartTable.beginUpdates()
            userData.cart.items.remove(at: indexPath.row)
            userData.cart.soLuong.remove(at: indexPath.row)
            userData.cart.price.remove(at: indexPath.row)
            userData.cart.image.remove(at: indexPath.row)
            cartTable.deleteRows(at: [indexPath], with: .fade)
            cartTable.endUpdates()
            cartTable.reloadData()
        }
    }
}
struct User {
    var name: String
    var avatar: String
    var mail: String
    var sđt: String
    var address: String
    var rank: String
    var cart: Cart
}
struct Cart {
    var items: [String]
    var price: [Double]
    var image: [String]
    var soLuong: [Int]
}
extension Array where Element: Equatable {
    func indexes(of value: Element) -> [Int] {
        return self.indices.filter { self[$0] == value }
    }
}
