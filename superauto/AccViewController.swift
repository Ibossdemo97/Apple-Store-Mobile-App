//
//  AccViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 05/12/2022.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase

var userData = User(name: String(), avatar: String(), mail: String(), sđt: String(), address: String(), rank: String(),
                    cart: Cart(items: [String](), price: [Double](), image: [String](), soLuong: [Int]()))

let buttonInTableSetting = ["Lịch sử đơn hàng", "Thay đổi ngôn ngữ", "Chính sách và quyền", "Thông tin ứng dụng", "Trợ giúp và hỗ trợ", ]

class AccViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var avatarUser: UIImageView!
    @IBOutlet weak var nameTV: UILabel!
    @IBOutlet weak var rankUser: UITextView!
    @IBOutlet weak var switchScreen: UIButton!
    @IBOutlet weak var tableOrder: UITableView!
    @IBOutlet weak var tableSetting: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAccScreen()
        tableOrder.delegate = self
        tableOrder.dataSource = self
        tableOrder.isUserInteractionEnabled = true
        tableSetting.allowsSelection = true
        
        tableSetting.dataSource = self
        tableSetting.delegate = self
        tableSetting.isUserInteractionEnabled = true
        tableSetting.allowsSelection = true
        
        if Auth.auth().currentUser == nil {
            let imageEmpty = UIImageView(frame: CGRect(x: 0, y: 0, width: tableOrder.frame.width, height: tableOrder.frame.width * 0.96 ))
            imageEmpty.image = UIImage(named: "order empty")
            imageEmpty.contentMode = .scaleAspectFit
            tableOrder.addSubview(imageEmpty)
        } else { }
    }
    override func viewDidAppear(_ animated: Bool) {
        tableOrder.reloadData()
        setupAccScreen()
    }
    func getUserData() {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            var ref: DatabaseReference!
            ref = Database.database().reference().child("userData").child(uid)
            ref.child("userData").observe(.value) { (snapshot, _) in
                guard let data = snapshot.value as? [String: Any] else { return }
                let name = data["name"] as? String ?? String()
                let mail = data["mail"] as? String ?? String()
                let address = data["địa chỉ"] as? String ?? String()
                let rank = data["rank"] as? String ?? String()
                let sđt = data["sđt"] as? String ?? String()
                let avatar = data["avatar"] as? String ?? String()
                userData.name = name
                userData.mail = mail
                userData.rank = rank
                userData.address = address
                userData.sđt = sđt
                userData.avatar = avatar
            }
        } else {
            let alert = UIAlertController(title: "Thông báo", message: "Lỗi lấy thông tin tài khoản\nVui lòng quay lại sau vài phút", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
    }
    func setupAccScreen() {
        if Auth.auth().currentUser != nil {
            nameTV.text = userData.name
            rankUser.text = " Thành viên \(userData.rank) - ưu đãi 0%"
            switchScreen.setTitle("Đăng xuất hoặc chỉnh sửa tài khoản", for: .normal)
            getUserData()
        } else {
            nameTV.text = "What is your name?"
            rankUser.text = "Đăng nhập để nhận ưu đãi"
            switchScreen.setTitle("Đăng nhập hoặc đăng ký để được hỗ trợ tốt nhất", for: .normal)
            let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
            view.addGestureRecognizer(tapGesture)
            if userData.avatar.isEmpty == true {
                avatarUser.image = UIImage(named: "defaultavatar")
            } else {
                avatarUser.sd_setImage(with: URL(string: userData.avatar))
            }
        }
    }
    @IBAction func tapToSwitchSceen(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let vc = storyboard?.instantiateViewController(withIdentifier: "UploadViewController") as! UploadViewController
            present(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableOrder  {
            return 320
        } else {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableOrder {
            return orderBillDetail.count
        } else {
            return buttonInTableSetting.count
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableOrder{
            print("🤣🤣🤣OK")
        } else if tableView == tableSetting {
            print("🥶🥶🥶\(indexPath.row) đã được nhấn")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableOrder  {
            let cell = tableOrder.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
            cell.orderNumber.text = "ĐƠN HÀNG SỐ: \(orderBillDetail[indexPath.row].orderNumber)"
            cell.orderPrice.text = "Tổng tiền: \(orderBillDetail[indexPath.row].orderPrice)00.000Vnđ"
            if orderBillDetail.isEmpty == true {
                cell.inforDetailTV.text = "\(orderBillDetail[indexPath.row].intendTimeOD)\n\(orderBillDetail[indexPath.row].inforDetailOD[0])\n\(orderBillDetail[indexPath.row].inforDetailOD[1])\n\(orderBillDetail[indexPath.row].inforDetailOD[2])\n\(orderBillDetail[indexPath.row].inforDetailOD[3])\n\(orderBillDetail[indexPath.row].inforDetailOD[4])"
                cell.collecOrder.tag = indexPath.row
            } else { }
            return cell
        } else {
            let cell = tableSetting.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
            cell.textLabel?.text = buttonInTableSetting[indexPath.row]
            return cell
        }
    }
}

