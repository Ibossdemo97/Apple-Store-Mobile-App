//
//  LoginViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 07/12/2022.
//

import UIKit
import FirebaseAuth
import AuthenticationServices
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var logoLoginImage: UIImageView!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var showHidePass: UIButton!
    @IBOutlet weak var loginBT: UIButton!
    @IBOutlet weak var registerBT: UIButton!
    @IBOutlet weak var loginWithAppleIDBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginVC()
        let showPasswordImage = UIImage(systemName: "eye")
        showHidePass.setImage(showPasswordImage, for: .normal)
        showHidePass.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
    }

    
    @IBAction func tapToLoginBT(_ sender: Any) {
        let mail = phoneTF.text ?? ""
        let pass = passTF.text ?? ""
        Auth.auth().signIn(withEmail: mail, password: pass) { (user ,error) in
            if let error = error {
                let alert = UIAlertController(title: "Thông báo", message: "Sai thông tin đăng nhập\nLỗi: \(String(describing: error))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            } else {
                //            self.getDataForCart()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                let loading = UIActivityIndicatorView(style: .medium)
//                loading.center = self.view.center
//                self.view.addSubview(loading)
//                loading.startAnimating()
//                loading.stopAnimating()
                self.getDataForCart()
                    let vc = self.storyboard?.instantiateViewController(identifier: "mainVC") as! MainViewController
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .flipHorizontal
                    self.present(vc, animated: true, completion: nil)
//                }
            }
        }
    }
    @IBAction func tapToRegisterBT(_ sender: Any) {
    }
    @IBAction func tapToAppleIDBT(_ sender: ASAuthorizationAppleIDButton) {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//          let request = appleIDProvider.createRequest()
//          request.requestedScopes = [.fullName, .email]
//
//          let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//          authorizationController.delegate = self
//          authorizationController.presentationContextProvider = self
//          authorizationController.performRequests()
    }
    func getDataForCart() {
        if Auth.auth().currentUser != nil {
            var ref: DatabaseReference!
            let uid = Auth.auth().currentUser?.uid
            ref = Database.database().reference().child("userData").child(uid!)
            ref.child("cart").observe(.value) { (snapshot, _) in
                guard let data = snapshot.value as? [String: Any] else { return }
                let items = data["name"] as? [String] ?? [String]()
                let price = data["price"] as? [Double] ?? [Double]()
                let image = data["image"] as? [String] ?? [String]()
                let soLuong = data["quantity"] as? [Int] ?? [Int]()
                userData.cart.items = items
                userData.cart.price = price
                userData.cart.image = image
                userData.cart.soLuong = soLuong
            }
        }  else { }
    }
    func setupLoginVC() {
        phoneTF.placeholder = "Địa chỉ mail"
        passTF.placeholder = "Mật khẩu"
        phoneTF.becomeFirstResponder()
        passTF.becomeFirstResponder()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    func checkPhoneAndPass() {

    }
    @objc func showPasswordButtonTapped() {
        passTF.isSecureTextEntry.toggle()
        let buttonTitle = passTF.isSecureTextEntry ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash")
        showHidePass.setImage(buttonTitle, for: .normal)
    }
    @IBAction func forgotPassword(_ sender: Any) {
        guard let mail = phoneTF.text, !mail.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng điền mail hợp lệ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        Auth.auth().sendPasswordReset(withEmail: mail) { error in
            if let error = error {
                let alert = UIAlertController(title: "Thông báo", message: "Gửi mail không thành công\nLỗi: \(String(describing: error))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Thử lại", style: .cancel))
                self.present(alert, animated: true)
            return
            }
            let alert = UIAlertController(title: "Thông báo", message: "Gửi mail thành công\nVui lòng kiểm tra mail", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        }
    }
}
