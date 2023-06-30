//
//  GetDataViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 05/01/2023.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

class GetDataViewController: UIViewController {
    
    //    let database = Database.database().reference()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataForTable()
        
    }
    func getDataForTable() {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
        } else { }
    }
}

