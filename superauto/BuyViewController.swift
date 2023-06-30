//
//  BuyViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 29/11/2022.
//

import UIKit
import Cosmos
import TinyConstraints
import SDWebImage
import FirebaseDatabase
import FirebaseAuth

var imageProducts = [String]()
var indexItem: Int = 0
var costAll = Double()

var tutorial0 = ["", "", "", "", "", ""]

var items1 = [String]()
var items2 = [String]()
var items3 = [String]()
var items4 = [String]()
var items5 = [String]()
var items6 = [String]()

var cost1 = [Double]()
var cost2 = [Double]()
var cost3 = [Double]()
var cost4 = [Double]()
var cost5 = [Double]()
var cost6 = [Double]()

var costA: Double = 0.0
var costB: Double = 0.0
var costC: Double = 0.0
var costD: Double = 0.0
var costE: Double = 0.0
var costF: Double = 0.0

var testA = 0
var testB = 0
var testC = 0
var testD = 0
var testE = 0
var testF = 0

var rollPerColor = 0
var rollPerAllImage = 0

var nameOP1 = ""
var nameOP2 = ""
var nameOP3 = ""
var nameOP4 = ""
var nameOP5 = ""
var nameOP6 = ""

var heightLBSM_range_margin = [50, 12, 10]

class BuyViewController: UIViewController {
    
    @IBOutlet weak var scrollProduct: UIScrollView!
    @IBOutlet weak var imageProduct: UICollectionView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var nameLB1: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var viewAllRating: UIButton!
    @IBOutlet weak var statusProduct: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var moreInformationTV: UITextView!
    
    @IBOutlet weak var addToBag: UIButton!
    @IBOutlet weak var buyNow: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLB.text = "\(child2) \(productsDetail.detailBasic.modelName[test - 1])"
        statusProduct.text = productsDetail.detailBasic.statusProducts[test - 1]
        price.text = "\(productsDetail.detailBasic.cost[test - 1])00.000Vnđ"
        rollPerColor = productsDetail.detailBasic.numberImagePerColor[test - 1]
        rollPerAllImage = productsDetail.detailBasic.numberImageAllColor[test - 1]
        
        setupRating()
        setupBuyNowAndAddToBag()
        
        switch test {
        case 1:
            imageProducts = productsDetail.imageProducts.imageProducts1
            tutorial0 = productsDetail.tutorial.tutorial1
        case 2:
            imageProducts = productsDetail.imageProducts.imageProducts2
            tutorial0 = productsDetail.tutorial.tutorial2
        case 3:
            imageProducts = productsDetail.imageProducts.imageProducts3
            tutorial0 = productsDetail.tutorial.tutorial3
        case 4:
            imageProducts = productsDetail.imageProducts.imageProducts4
            tutorial0 = productsDetail.tutorial.tutorial4
        case 5:
            imageProducts = productsDetail.imageProducts.imageProducts5
            tutorial0 = productsDetail.tutorial.tutorial5
        case 6:
            imageProducts = productsDetail.imageProducts.imageProducts6
            tutorial0 = productsDetail.tutorial.tutorial6
        default:
            let alert = UIAlertController(title: "Thông báo", message: "Hệ thống đang cập nhật dữ liệu", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }

        if productsDetail.option1[test - 1].option.isEmpty == false {
            items1 = productsDetail.option1[test - 1].option
            cost1 = productsDetail.option1[test - 1].cost
            setupSegment1() } else { testA = 7 }
        if productsDetail.option2[test - 1].option.isEmpty == false {
            items2 = productsDetail.option2[test - 1].option
            cost2 = productsDetail.option2[test - 1].cost
            setupSegment2() } else { testB = 7 }
        if productsDetail.option3[test - 1].option.isEmpty == false {
            items3 = productsDetail.option3[test - 1].option
            cost3 = productsDetail.option3[test - 1].cost
            setupSegment3() } else { testC = 7 }
        if productsDetail.option4[test - 1].option.isEmpty == false {
            items4 = productsDetail.option4[test - 1].option
            cost4 = productsDetail.option4[test - 1].cost
            setupSegment4() } else { testD = 7 }
        if productsDetail.option5[test - 1].option.isEmpty == false {
            items5 = productsDetail.option5[test - 1].option
            cost5 = productsDetail.option5[test - 1].cost
            setupSegment5() } else { testE = 7 }
        if productsDetail.option6[test - 1].option.isEmpty == false {
            items6 = productsDetail.option6[test - 1].option
            cost6 = productsDetail.option6[test - 1].cost
            setupSegment6() } else { testF = 7 }
        
        let arrayCheck = [testA, testB, testC, testD, testE, testF]
        if let index = arrayCheck.firstIndex(of: 7) {
            let space = ((heightLBSM_range_margin[0] + heightLBSM_range_margin[2])) * (index - 1)
            moreInformationTV.frame = CGRect(x: 0, y: Int(statusProduct.frame.maxY + statusProduct.frame.height) + space, width: Int(view1.frame.width), height: 100)
        }
        
        imageProduct.dataSource = self
        imageProduct.delegate = self
    
        title = "Chọn cấu hình phù hợp"
        imageProduct.contentSize = CGSize(width: view.frame.width * CGFloat(productsDetail.imageProducts.imageProducts1.count), height: view.frame.width)

        let rightButton = UIBarButtonItem(title: "Thông số", style: .done, target: self, action: #selector(rightButtonPressed(_:)))
        self.navigationItem.rightBarButtonItems = [rightButton]
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Trở về", style: .done, target: self, action: nil)
        
    }
    @objc func rightButtonPressed(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "specs") as! SpecsViewController
        navigationController?.show(vc, sender: nil)
    }
    func checkBill() {
        costAll = productsDetail.detailBasic.cost[test - 1] + costA + costB + costC + costD + costE + costF
            price.text = "\(costAll)00.000Vnđ"
        nameLB.text = "\(child2) \(productsDetail.detailBasic.modelName[test - 1]) \(nameOP1) \(nameOP2) \(nameOP3)"
            nameLB1.text = "\(nameOP4) \(nameOP5) \(nameOP6)"
    }
    func setupBuyNowAndAddToBag() {
        addToBag.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        buyNow.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        if productsDetail.detailBasic.statusProducts[test - 1] != "Còn hàng" {
            buyNow.alpha = 0.5
        } else {
            buyNow.alpha = 1
//            buyNow.addTarget(self, action: #selector(tapBuyNow), for: .touchUpInside)
        }
    }
    @objc func tapBuyNow(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BuyNowViewController") as! BuyNowViewController
        navigationController?.show(vc, sender: nil)
    }
    func setupRating() {
        let textComment: String = {
            return "Xem tất cả \(productsDetail.detailBasic.numberOfCmt[test - 1]) bình luận"
        }()
        viewRating.settings.updateOnTouch = false
        viewRating.settings.starMargin = 5
        viewRating.settings.fillMode = .precise
        viewRating.settings.textColor = .red
        viewRating.settings.textFont = UIFont.systemFont(ofSize: 17)
        viewRating.rating = productsDetail.detailBasic.ratting[test - 1]
        viewRating.text = "\(productsDetail.detailBasic.ratting[test - 1])"
        viewAllRating.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        viewAllRating.layer.masksToBounds = true
        viewAllRating.setTitle(textComment, for: .normal)
//        viewAllRating.addTarget(self, action: #selector(createButtonRatting), for: .touchUpInside)
    }
    func setupSegment1() {
        let segment = UISegmentedControl(items: items1)
        segment.addTarget(self, action: #selector(changeSegment1), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        let tutorial = UILabel()
        tutorial.frame.size = CGSize(width: view1.frame.width - 2 * CGFloat(heightLBSM_range_margin[2]), height: CGFloat(heightLBSM_range_margin[1]))
        tutorial.font = UIFont.systemFont(ofSize: CGFloat(heightLBSM_range_margin[1]))
        tutorial.translatesAutoresizingMaskIntoConstraints = false
        tutorial.textColor = .cyan
        tutorial.text = tutorial0[0]
        
        view1.addSubview(segment)
        view1.addSubview(tutorial)
        
        NSLayoutConstraint.activate([
            tutorial.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: CGFloat(heightLBSM_range_margin[2])),
            tutorial.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -CGFloat(heightLBSM_range_margin[2])),
            tutorial.topAnchor.constraint(equalTo: statusProduct.bottomAnchor, constant: CGFloat(heightLBSM_range_margin[0] * 0)),
            
            segment.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: CGFloat(heightLBSM_range_margin[1])),
            segment.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -CGFloat(heightLBSM_range_margin[1])),
            segment.topAnchor.constraint(equalTo: imageProduct.bottomAnchor, constant: CGFloat(heightLBSM_range_margin[0] * 1)),
            

        ])
    }
    @objc func changeSegment1(_ sender1: UISegmentedControl) {
        switch sender1.selectedSegmentIndex {
        case 0:
            nameOP1 = "\(items1[0])"
            indexItem = rollPerAllImage * 1
            imageProduct.scrollToItem(at: IndexPath(item: indexItem, section: 0), at: .right, animated: true)
            costA = cost1[0]
            testA = 1
        case 1:
            nameOP1 = "\(items1[1])"
            indexItem = rollPerColor * 1 + rollPerAllImage
            imageProduct.scrollToItem(at: IndexPath(item: indexItem, section: 0), at: .right, animated: true)
            costA = cost1[2]
            testA = 2
        case 2:
            nameOP1 = "\(items1[2])"
            indexItem = rollPerColor * 2 + rollPerAllImage
            imageProduct.scrollToItem(at: IndexPath(item: indexItem, section: 0), at: .right, animated: true)
            costA = cost1[2]
            testA = 3
        case 3:
            nameOP1 = "\(items1[3])"
            indexItem = rollPerColor * 3 + rollPerAllImage
            imageProduct.scrollToItem(at: IndexPath(item: indexItem, section: 0), at: .right, animated: true)
            costA = cost1[3]
            testA = 4
        case 4:
            nameOP1 = "\(items1[4])"
            indexItem = rollPerColor * 4 + rollPerAllImage
            imageProduct.scrollToItem(at: IndexPath(item: indexItem, section: 0), at: .right, animated: true)
            costA = cost1[4]
            testA = 5
        case 5:
            nameOP1 = "\(items1[5])"
            indexItem = rollPerColor * 5 + rollPerAllImage
            imageProduct.scrollToItem(at: IndexPath(item: indexItem, section: 0), at: .right, animated: true)
            costA = cost1[5]
            testA = 6
        default:
            nameOP1 = "\(items1[0])"
            imageProduct.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
            testA = 0
        }
        checkBill()
    }
    func setupSegment2() {
        let segment = UISegmentedControl(items: items2)
        segment.addTarget(self, action: #selector(changeSegment2), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        let tutorial = UILabel()
        tutorial.frame.size = CGSize(width: view1.frame.width - 2 * CGFloat(heightLBSM_range_margin[1]), height: CGFloat(heightLBSM_range_margin[1]))
        tutorial.font = UIFont.systemFont(ofSize: CGFloat(heightLBSM_range_margin[1]))
        tutorial.translatesAutoresizingMaskIntoConstraints = false
        tutorial.textColor = .cyan
        tutorial.text = tutorial0[1]
        
        view1.addSubview(segment)
        view1.addSubview(tutorial)
        
        NSLayoutConstraint.activate([
            tutorial.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: CGFloat(heightLBSM_range_margin[2])),
            tutorial.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -CGFloat(heightLBSM_range_margin[2])),
            tutorial.topAnchor.constraint(equalTo: statusProduct.bottomAnchor, constant: CGFloat(heightLBSM_range_margin[0] * 1)),

            segment.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: CGFloat(heightLBSM_range_margin[1])),
            segment.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -CGFloat(heightLBSM_range_margin[1])),
            segment.topAnchor.constraint(equalTo: imageProduct.bottomAnchor, constant: CGFloat(heightLBSM_range_margin[0] * 2))
        ])
    }
    @objc func changeSegment2(_ sender2: UISegmentedControl) {
        switch sender2.selectedSegmentIndex {
        case 0:
            nameOP2 = "\(items2[0])"
            costB = cost2[0]
            testB = 1
        case 1:
            nameOP2 = "\(items2[1])"
            costB = cost2[1]
            testB = 2
        case 2:
            nameOP2 = "\(items2[2])"
            costB = cost2[2]
            testB = 3
        case 3:
            nameOP2 = "\(items2[3])"
            costB = cost2[3]
            testB = 4
        case 4:
            nameOP2 = "\(items2[4])"
            costB = cost2[4]
            testB = 5
        case 5:
            nameOP2 = "\(items2[5])"
            costB = cost2[5]
            testB = 6
        default:
            nameOP2 = "\(items2[0])"
            testB = 0
        }
        checkBill()
    }
    func setupSegment3() {
        let segment = UISegmentedControl(items: items3)
        segment.addTarget(self, action: #selector(changeSegment3), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        let tutorial = UILabel()
        tutorial.frame.size = CGSize(width: view1.frame.width - 2 * CGFloat(heightLBSM_range_margin[2]), height: CGFloat(heightLBSM_range_margin[1]))
        tutorial.font = UIFont.systemFont(ofSize: CGFloat(heightLBSM_range_margin[1]))
        tutorial.translatesAutoresizingMaskIntoConstraints = false
        tutorial.textColor = .cyan
        tutorial.text = tutorial0[2]
        
        view1.addSubview(segment)
        view1.addSubview(tutorial)
        
        NSLayoutConstraint.activate([
            tutorial.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: CGFloat(heightLBSM_range_margin[2])),
            tutorial.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -CGFloat(heightLBSM_range_margin[2])),
            tutorial.topAnchor.constraint(equalTo: statusProduct.bottomAnchor, constant: CGFloat(heightLBSM_range_margin[0] * 2)),
            
            segment.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: CGFloat(heightLBSM_range_margin[1])),
            segment.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -CGFloat(heightLBSM_range_margin[1])),
            segment.topAnchor.constraint(equalTo: imageProduct.bottomAnchor, constant: CGFloat(heightLBSM_range_margin[0] * 3))
        ])
    }
    @objc func changeSegment3(_ sender3: UISegmentedControl) {
        switch sender3.selectedSegmentIndex {
        case 0:
            nameOP3 = "\(items3[0])"
            costC = cost3[0]
            testC = 1
        case 1:
            nameOP3 = "\(items3[1])"
            costC = cost3[1]
            testC = 2
        case 2:
            nameOP3 = "\(items3[2])"
            costC = cost3[2]
            testC = 3
        case 3:
            nameOP3 = "\(items3[3])"
            costC = cost3[3]
            testC = 4
        case 4:
            nameOP3 = "\(items3[4])"
            costC = cost3[4]
            testC = 5
        case 5:
            nameOP3 = "\(items3[5])"
            costC = cost3[5]
            testC = 6
        default:
            nameOP3 = "\(items3[0])"
            testC = 0
        }
        checkBill()
    }
    func setupSegment4() {
        let segment = UISegmentedControl(items: items4)
        segment.addTarget(self, action: #selector(changeSegment4), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        let tutorial = UILabel()
        tutorial.frame.size = CGSize(width: view1.frame.width - 2 * CGFloat(heightLBSM_range_margin[2]), height: CGFloat(heightLBSM_range_margin[1]))
        tutorial.font = UIFont.systemFont(ofSize: CGFloat(heightLBSM_range_margin[1]))
        tutorial.translatesAutoresizingMaskIntoConstraints = false
        tutorial.textColor = .cyan
        tutorial.text = tutorial0[3]
        
        view1.addSubview(segment)
        view1.addSubview(tutorial)
        
        NSLayoutConstraint.activate([
            tutorial.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: CGFloat(heightLBSM_range_margin[2])),
            tutorial.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -CGFloat(heightLBSM_range_margin[2])),
            tutorial.topAnchor.constraint(equalTo: statusProduct.bottomAnchor, constant: CGFloat(heightLBSM_range_margin[0] * 3)),
            
            segment.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: CGFloat(heightLBSM_range_margin[2])),
            segment.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -CGFloat(heightLBSM_range_margin[2])),
            segment.topAnchor.constraint(equalTo: imageProduct.bottomAnchor, constant: CGFloat(heightLBSM_range_margin[0] * 4))
        ])
    }
    @objc func changeSegment4(_ sender4: UISegmentedControl) {
        switch sender4.selectedSegmentIndex {
        case 0:
            nameOP4 = "\(items4[0])"
            costD = cost4[0]
            testD = 1
        case 1:
            nameOP4 = "\(items4[1])"
            costD = cost4[1]
            testD = 2
        case 2:
            nameOP4 = "\(items4[2])"
            costD = cost4[2]
            testD = 3
        case 3:
            nameOP4 = "\(items4[3])"
            costD = cost4[3]
            testD = 4
        case 4:
            nameOP4 = "\(items4[4])"
            costD = cost4[4]
            testD = 5
        case 5:
            nameOP4 = "\(items4[5])"
            costD = cost4[5]
            testD = 6
        default:
            testD = 0
        }
        checkBill()
    }
    func setupSegment5() {
        let segment = UISegmentedControl(items: items5)
        segment.addTarget(self, action: #selector(changeSegment5), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        let tutorial = UILabel()
        tutorial.frame.size = CGSize(width: view1.frame.width - 2 * CGFloat(heightLBSM_range_margin[2]), height: CGFloat(heightLBSM_range_margin[1]))
        tutorial.font = UIFont.systemFont(ofSize: CGFloat(heightLBSM_range_margin[1]))
        tutorial.translatesAutoresizingMaskIntoConstraints = false
        tutorial.textColor = .cyan
        tutorial.text = tutorial0[4]
        
        view1.addSubview(segment)
        view1.addSubview(tutorial)
        
        NSLayoutConstraint.activate([
            tutorial.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: CGFloat(heightLBSM_range_margin[2])),
            tutorial.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -CGFloat(heightLBSM_range_margin[2])),
            tutorial.topAnchor.constraint(equalTo: statusProduct.bottomAnchor, constant: CGFloat(heightLBSM_range_margin[0] * 4)),
            
            segment.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: CGFloat(heightLBSM_range_margin[1])),
            segment.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -CGFloat(heightLBSM_range_margin[1])),
            segment.topAnchor.constraint(equalTo: imageProduct.bottomAnchor, constant:  CGFloat(heightLBSM_range_margin[0] * 5))
        ])
    }
    @objc func changeSegment5(_ sender5: UISegmentedControl) {
        switch sender5.selectedSegmentIndex {
        case 0:
            nameOP5 = "\(items5[0])"
            costE = cost5[0]
            testE = 1
        case 1:
            nameOP5 = "\(items5[1])"
            costE = cost5[1]
            testE = 2
        case 2:
            nameOP5 = "\(items5[2])"
            costE = cost5[2]
            testE = 3
        case 3:
            nameOP5 = "\(items5[3])"
            costE = cost5[3]
            testE = 4
        case 4:
            nameOP5 = "\(items5[4])"
            costE = cost5[4]
            testE = 5
        case 5:
            nameOP5 = "\(items5[5])"
            costE = cost5[5]
            testE = 6
        default:
            testE = 0
        }
        checkBill()
    }
    func setupSegment6() {
        let segment = UISegmentedControl(items: items6)
        segment.addTarget(self, action: #selector(changeSegment6), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        let tutorial = UILabel()
        tutorial.frame.size = CGSize(width: view1.frame.width - 2 * CGFloat(heightLBSM_range_margin[2]), height: CGFloat(heightLBSM_range_margin[1]))
        tutorial.font = UIFont.systemFont(ofSize: CGFloat(heightLBSM_range_margin[1]))
        tutorial.translatesAutoresizingMaskIntoConstraints = false
        tutorial.textColor = .cyan
        tutorial.text = tutorial0[5]
        
        view1.addSubview(segment)
        view1.addSubview(tutorial)
        
        NSLayoutConstraint.activate([
            tutorial.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: CGFloat(heightLBSM_range_margin[2])),
            tutorial.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -CGFloat(heightLBSM_range_margin[2])),
            tutorial.topAnchor.constraint(equalTo: statusProduct.bottomAnchor, constant: CGFloat(heightLBSM_range_margin[0] * 5)),
            
            segment.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: CGFloat(heightLBSM_range_margin[2])),
            segment.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -CGFloat(heightLBSM_range_margin[2])),
            segment.topAnchor.constraint(equalTo: imageProduct.bottomAnchor, constant: CGFloat(heightLBSM_range_margin[0] * 6))
        ])
    }
    @objc func changeSegment6(_ sender6: UISegmentedControl) {
        switch sender6.selectedSegmentIndex {
        case 0:
            nameOP6 = "\(items6[0])"
            costF = cost6[0]
            testF = 1
        case 1:
            nameOP6 = "\(items6[1])"
            costF = cost6[1]
            testF = 2
        case 2:
            nameOP6 = "\(items6[2])"
            costF = cost6[2]
            testF = 3
        case 3:
            nameOP6 = "\(items6[3])"
            costF = cost6[3]
            testF = 4
        case 4:
            nameOP6 = "\(items6[4])"
            costF = cost6[4]
            testF = 5
        case 5:
            nameOP6 = "\(items6[5])"
            costF = cost6[5]
            testF = 6
        default:
            testF = 0
        }
        checkBill()
    }
    @IBAction func tapToAddBag(_ sender: Any) {
        if testA != 0 && testB != 0 && testC != 0 && testD != 0 && testE != 0 && testF != 0 {
            showAlertTrue()
            sendData()
        } else {
            showAlertFalse()
        }
    }
    @IBAction func tapToBuyNow(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            if testA != 0 && testB != 0 && testC != 0 && testD != 0 && testE != 0 && testF != 0 {
                sendData()
                let vc = storyboard?.instantiateViewController(withIdentifier: "BuyNowViewController") as! BuyNowViewController
                navigationController?.show(vc, sender: nil)
            } else {
                showAlertFalse()
            }
        } else {
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
        }
    }
    @IBAction func tapToViewRatting(_ sender: Any) {
    }
    func showAlertTrue() {
        let alert = UIAlertController(title: "Thông báo", message: "Thêm vào giỏ hàng thành công", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    func showAlertFalse() {
        let alert = UIAlertController(title: "Thông báo", message: "Vui lòng chọn đầy đủ cấu hình", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Chọn lại", style: .cancel))
        present(alert, animated: true)
    }
    func sendData() {
        let nameSend = "\(nameLB.text!) \( nameLB1.text!)"
        let priceSend = costAll
        let imageSend = imageProducts[indexItem]
        userData.cart.items += ["\(nameSend)"]
        userData.cart.price += [priceSend]
        userData.cart.image += ["\(imageSend)"]
        userData.cart.soLuong += [1]
        
        let ref = Database.database().reference()
        let childUpdates = [
            "/userData/XVmwRw26FqeB7ZVqXvfSxTYj59v2/userData/cart/items": userData.cart.items,
            "/userData/XVmwRw26FqeB7ZVqXvfSxTYj59v2/userData/cart/image":  userData.cart.image,
            "/userData/XVmwRw26FqeB7ZVqXvfSxTYj59v2/userData/cart/price": userData.cart.price,
            "/userData/XVmwRw26FqeB7ZVqXvfSxTYj59v2/userData/cart/soLuong": userData.cart.soLuong
        ] as [String : Any]
        ref.updateChildValues(childUpdates) { (error, ref) in
            if let error = error {
                print(error)
            } else {
            }
        }
    }
}
extension BuyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageProduct.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BuyImageCollectionViewCell
        cell.imageProduct.sd_setImage(with: URL(string: imageProducts[indexPath.row]))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
