//
//  UploadImageViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 03/01/2023.
//

import UIKit
import FirebaseStorage

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    private let storage = Storage.storage().reference()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUploadVC()
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else {
                  return
              }
        label.text = urlString
         
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        })
        task.resume()
    }
    func setupUploadVC() {
        label.numberOfLines = 0
        label.textAlignment = .center
        imageView.contentMode = .scaleAspectFit
    }
    @IBAction func diaTapButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        storage.child("image/file.png").putData(imageData, metadata: nil,completion: { _, error in
            guard error == nil else {
                print("Lỗi tải ảnh lên")
                return
            }
            self.storage.child("image/file.png").downloadURL(completion: { url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                DispatchQueue.main.async {
                    self.label.text = urlString
                    self.imageView.image = image
                }
                print("Download URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
            })
        })
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
//import FirebaseStorage
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var uploadButton: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Initialize FirebaseApp
//        FirebaseApp.configure()
//    }
//
//    @IBAction func uploadButtonPressed(_ sender: UIButton) {
//        // Create a unique filename for the uploaded image
//        let imageName = UUID().uuidString + ".jpg"
//
//        // Get a reference to the Firebase Storage bucket
//        let storageRef = Storage.storage().reference()
//
//        // Create a reference to the uploaded image file
//        let imageRef = storageRef.child("images/\(imageName)")
//
//        // Compress the image and convert it to JPEG format
//        guard let imageData = imageView.image?.jpegData(compressionQuality: 0.5) else {
//            return
//        }
//
//        // Upload the image to Firebase Storage
//        let uploadTask = imageRef.putData(imageData, metadata: nil) { metadata, error in
//            if let error = error {
//                print("Error uploading image: \(error.localizedDescription)")
//                return
//            }
//
//            // Get the download URL of the uploaded image
//            imageRef.downloadURL { url, error in
//                if let error = error {
//                    print("Error getting download URL: \(error.localizedDescription)")
//                    return
//                }
//
//                guard let downloadURL = url else {
//                    return
//                }
//
//                // Print the download URL of the uploaded image
//                print("Download URL: \(downloadURL)")
//            }
//        }
//
//        // Observe the upload progress
//        uploadTask.observe(.progress) { snapshot in
//            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
//            print("Upload progress: \(percentComplete)%")
//        }
//    }
//}
