//
//  UploadViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 15/03/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var changeAvatarBT: UIButton!
    @IBOutlet weak var changeNameTF: UITextField!
    @IBOutlet weak var changePhoneTF: UITextField!
    @IBOutlet weak var changeAddressTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeNameTF.text = userData.name
        changePhoneTF.text = userData.sđt
        changeAddressTF.text = userData.address
    }
    @IBAction func changeAvatarBT(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func confirmationBT(_ sender: Any) {
        let phoneUpdate = changePhoneTF.text!
        let nameUpdate = changeNameTF.text!
        let addressUpdate = changeAddressTF.text!
        let imageUpdate = ""
        
        if phoneUpdate.isEmpty == true || nameUpdate.isEmpty == true || addressUpdate.isEmpty == true {
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng điền đầy đủ thông tin để chúng tôi hỗ trợ bạn tốt nhất", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Quay lại", style: .cancel))
            self.present(alert, animated: true)
        } else {
            let ref = Database.database().reference()
            let uid = Auth.auth().currentUser?.uid
            let childUpdates = [
                "/userData/\(String(describing: uid))/userData/name": nameUpdate,
                "/userData/\(String(describing: uid))/userData/sđt": phoneUpdate,
                "/userData/\(String(describing: uid))/userData/address": addressUpdate,
                "/userData/\(String(describing: uid))/userData/image": ""
            ]
            ref.updateChildValues(childUpdates) { (error, ref) in
                if let error = error {
                    let alert = UIAlertController(title: "Thông báo", message: "Lỗi cập nhật dữ liệu\nLỗi: \(String(describing: error))", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Chờ vài phút", style: .cancel))
                    self.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "Cập nhật dữ liệu thành công", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccViewController") as! AccViewController
                        self.present(vc, animated: true)
                    }))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    @IBAction func logoutBT(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainVC") as! MainViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        } catch let error as NSError {
            let alert = UIAlertController(title: "Thông báo", message: "Không thể đăng xuất\nLỗi: \(String(describing: error))", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("\(info)")
        }
        changeAvatarBT.setImage(selectedImage, for: .normal)
        guard let imageData = selectedImage.jpegData(compressionQuality: 1.0) else {
            fatalError("Không thể hiển thị hình ảnh")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
//class MyViewController: UIViewController {
//
//    @IBOutlet weak var uploadButton: UIButton!
//    var selectedImage: UIImage?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Add target for button
//        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
//    }
//
//    @objc func uploadButtonTapped() {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        present(imagePicker, animated: true, completion: nil)
//    }
//
//    func uploadImage(_ image: UIImage) {
//        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
//
//        // Get a reference to the Firebase Storage
//        let storageRef = Storage.storage().reference()
//
//        // Create a unique file name for the image
//        let imageRef = storageRef.child(UUID().uuidString + ".jpg")
//
//        // Upload the image data to Firebase Storage
//        imageRef.putData(imageData, metadata: nil) { (metadata, error) in
//            if let error = error {
//                print("Error uploading image: \(error.localizedDescription)")
//            } else {
//                // Get the download URL for the uploaded image
//                imageRef.downloadURL { (url, error) in
//                    if let error = error {
//                        print("Error getting download URL: \(error.localizedDescription)")
//                    } else if let url = url {
//                        // Update the button image with the uploaded image
//                        self.uploadButton.setImage(image, for: .normal)
//
//                        // Save the download URL for the uploaded image
//                        // (You can use this URL to display the image elsewhere in your app)
//                        print("Download URL: \(url.absoluteString)")
//                    }
//                }
//            }
//        }
//    }
//}
//
//// Implement UIImagePickerControllerDelegate and UINavigationControllerDelegate
//extension MyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//
//        // Get the selected image from the info dictionary
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            // Save the selected image and upload it to Firebase Storage
//            selectedImage = image
//            uploadImage(image)
//        }
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//}
