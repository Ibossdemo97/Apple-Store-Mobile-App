//
//  RegisterViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 07/12/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var topText: UITextView!
    @IBOutlet weak var phoneTutorialLB: UILabel!
    @IBOutlet weak var phoneRegisterTF: UITextField!
    @IBOutlet weak var passTutorialLB: UILabel!
    @IBOutlet weak var passRegisterTF: UITextField!
    @IBOutlet weak var passAgainTutorialLB: UILabel!
    @IBOutlet weak var passAgainRegisterTF: UITextField!
    @IBOutlet weak var nameTutorialLB: UILabel!
    @IBOutlet weak var nameRegisterTF: UITextField!
    @IBOutlet weak var mailTutorialLB: UILabel!
    @IBOutlet weak var mailRegisterTF: UITextField!
    @IBOutlet weak var addressLB: UILabel!
    @IBOutlet weak var addressTF: UITextField!
    
    @IBOutlet weak var registerDoneBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRegisterVC()
        
    }
//    func checkTF() {
//        if  phoneRegisterTF.text?.isEmpty == true ||
//                passRegisterTF.text?.isEmpty == true ||
//                passAgainRegisterTF.text?.isEmpty == true ||
//                nameRegisterTF.text?.isEmpty == true ||
//                mailRegisterTF.text?.isEmpty == true ||
//                passRegisterTF.text != passAgainRegisterTF.text ||
//                phoneRegisterTF.text?.count != 10
//        {
//            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng điền đầy đủ thông tin ", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
//            present(alert, animated: true)
//        } else {
//        }
//    }
    func showAlertRegisterDone() {
        let alert = UIAlertController(title: "Thông báo", message: "Đăng ký thành công", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    func showAlertRegisterFalse() {
        let alert = UIAlertController(title: "Thông báo", message: "Vui lòng điền thông tin hơp lệ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    func setupRegisterVC() {
        passRegisterTF.becomeFirstResponder()
        passAgainRegisterTF.becomeFirstResponder()
        nameRegisterTF.becomeFirstResponder()
        mailRegisterTF.becomeFirstResponder()
        phoneRegisterTF.becomeFirstResponder()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @IBAction func tapToRegisterDone(_ sender: UIButton) {
        let phoneNumber = phoneRegisterTF.text!
        let password = passRegisterTF.text!
        let passwordConfirmation = passAgainRegisterTF.text!
        let name = nameRegisterTF.text!
        let mail = mailRegisterTF.text!
        let address = addressTF.text!
        
        Auth.auth().signIn(withEmail: mail, password: password, completion: { [ weak self ] result, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                strongSelf.showScreen(mail: mail, pass: password)
                return
            }
        })
//        if let user = Auth.auth().currentUser {
//            let uidNew = user.uid
//            var ref: DatabaseReference!
//            ref = Database.database().reference()
//            ref.child("userData").setValue("\(uidNew)")
//            ref.child("userData").child("\(uidNew)").setValue([
//                "userData": ["name": name,
//                             "sđt": phoneNumber,
//                             "avatar": "",
//                             "mail": mail,
//                             "address": address,
//                             "rank": "",
//                             "cart": "",
//                             "yourOrder": ""
//                            ]
//            ])
//        } else {
//            print("🥶🥶🥶🥶 Không ổn rồi")
//        }
    }
    func showScreen(mail: String, pass: String) {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn muốn hoàn tất đăng ký", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tiếp tục", style: .default, handler: {_ in
            FirebaseAuth.Auth.auth().createUser(withEmail: mail, password: pass, completion: { [weak self] result, error in
                guard let strongSelf = self else {
                    return
                }
                guard error == nil else {
                    let alert = UIAlertController(title: "Thông báo", message: "Đăng ký không thành công\nLỗi: \(String(describing: error!))", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self?.present(alert, animated: true)
                    return
                }
                let alert = UIAlertController(title: "Chúc mừng", message: "Đăng ký thành công", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đăng nhập ngay", style: .cancel, handler: {_ in
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self?.present(vc, animated: true)
                }))
                self?.present(alert, animated: true)
            })
        }))
        alert.addAction(UIAlertAction(title: "Huỷ bỏ", style: .cancel, handler: {_ in }))
        present(alert, animated: true)
    }
}
//    @IBAction func phone_act(_ sender: Any) {
//        let text = phoneRegisterTF.text ?? ""
//        if text.isValidPhone() {
//            phoneTutorialLB.textColor = UIColor.black
//            phoneTutorialLB.text = ""
//        } else {
//            phoneTutorialLB.textColor = UIColor.black
//            phoneTutorialLB.text = "Số điện thoại không hợp lệ"
//        }
//    }
//    @IBAction func pass_act(_ sender: Any) {
//        let text = passRegisterTF.text ?? ""
//        if text.isValidPass() {
//            passTutorialLB.textColor = UIColor.black
//            passTutorialLB.text = ""
//        } else {
//            passTutorialLB.textColor = UIColor.red
//            passTutorialLB.text = "Mật khẩu yếu"
//        }
//    }
//    @IBAction func passAgain_act(_ sender: Any) {
//        let text = passAgainRegisterTF.text ?? ""
//        if text.isValidPassAgain() {
//            passAgainTutorialLB.textColor = UIColor.black
//            passAgainTutorialLB.text = ""
//        } else {
//            passAgainTutorialLB.textColor = UIColor.red
//            passAgainTutorialLB.text = "Mật khẩu không trùng khớp"
//        }
//    }
//    @IBAction func name_act(_ sender: Any) {
//        let text = nameRegisterTF.text ?? ""
//        if text.isValidPhone() {
//            nameTutorialLB.textColor = UIColor.black
//            nameTutorialLB.text = ""
//        } else {
//            nameTutorialLB.textColor = UIColor.red
//            nameTutorialLB.text = "Tên không hợp lệ"
//        }
//    }
//    @IBAction func mail_act(_ sender: Any) {
//        let text = mailRegisterTF.text ?? ""
//        if text.isValidPhone() {
//            mailTutorialLB.textColor = UIColor.black
//            mailTutorialLB.text = ""
//        } else {
//            mailTutorialLB.textColor = UIColor.black
//            mailTutorialLB.text = "Mail không hợp lệ"
//        }
//    }
//}
//extension String {
//    func isValidPhone() -> Bool {
//        let inputRegEx = ""
//        let inputpred = NSPredicate(format: "", inputRegEx)
//        return inputpred.evaluate(with: self)
//    }
//    func isValidPass() -> Bool {
//        let inputRegEx = ""
//        let inputpred = NSPredicate(format: "", inputRegEx)
//        return inputpred.evaluate(with: self)
//    }
//    func isValidPassAgain() -> Bool {
//        let inputRegEx = ""
//        let inputpred = NSPredicate(format: "", inputRegEx)
//        return inputpred.evaluate(with: self)
//    }
//    func isValidName() -> Bool {
//        let inputRegEx = ""
//        let inputpred = NSPredicate(format: "", inputRegEx)
//        return inputpred.evaluate(with: self)
//    }
//    func isValidMail() -> Bool {
//        let inputRegEx = ""
//        let inputpred = NSPredicate(format: "", inputRegEx)
//        return inputpred.evaluate(with: self)
//    }
//}
