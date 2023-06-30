//
//  ItemViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 29/11/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase
import SDWebImage

class ItemViewController: UIViewController {
    
    @IBOutlet weak var tableItems: UITableView!
    @IBOutlet weak var field: UITextField!

    var completionHandler: ((String) -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableItems.reloadData()
        tableItems.dataSource = self
        tableItems.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        tableItems.reloadData()
    }
    func moveOnProductsListing(index: Int) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Products") as? ProductViewController else { return }
        nameTitle = listPro[index].name
        child1 = listPro[index].name
        productsView.name = listPro[index].pro
        productsView.imageName = listImage[index].image
        present(vc, animated: true, completion: nil)
    }
}
extension ItemViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPro.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableItems.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! ItemsTableViewCell

        cell.imageCollection.tag = indexPath.row
        cell.namesItems.text = listPro[indexPath.row].name
        cell.index = indexPath.row
        cell.onClickViewAllClosure = { index in
            if let indexp = index {
                self.moveOnProductsListing(index: indexp)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.width / 1.618 + 50
    }
}


