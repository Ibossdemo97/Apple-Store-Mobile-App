//
//  CompareViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 29/11/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase

var sizeBT_margin = [172, 60, 5]

class CompareViewController: UIViewController {

    @IBOutlet weak var scrollCompare: UIScrollView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var imageCollec: UICollectionView!
    @IBOutlet weak var newCompare: UITextView!
    @IBOutlet weak var heightView1: NSLayoutConstraint!
    
    override func viewDidLayoutSubviews() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageCollec.dataSource = self
        imageCollec.delegate = self
        imageCollec.register(CompareImageCollectionViewCell.nib(), forCellWithReuseIdentifier: "cell")
        imageCollec.contentSize = CGSize(width: view.bounds.width * CGFloat(productsDetail.detailBasic.imageCompare.count), height: view.bounds.width)
        
        heightView1.constant = view.frame.width + newCompare.frame.height + CGFloat(sizeBT_margin[2] * (productsDetail.detailBasic.modelName.count + 2) + sizeBT_margin[1] * productsDetail.detailBasic.modelName.count)
    
        setupNavi()
        
        switch productsDetail.detailBasic.modelName.count {
        case 6:
            createButton1()
            createButton2()
            createButton3()
            createButton4()
            createButton5()
            createButton6()
        case 5:
            createButton1()
            createButton2()
            createButton3()
            createButton4()
            createButton5()
        case 4:
            createButton1()
            createButton2()
            createButton3()
            createButton4()
        case 3:
            createButton1()
            createButton2()
            createButton3()
        case 2:
            createButton1()
            createButton2()
        case 1:
            fastScreenSwitching()
        default:
            let alert = UIAlertController(title: "Thông báo", message: "Hệ thống đang cập nhật dữ liệu", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        test = 0
        testA = 0
        testB = 0
        testC = 0
        testD = 0
        testE = 0
        testF = 0
    }
    func fastScreenSwitching() {
        let alertController = UIAlertController(title: nil, message: "Đang tải\n\n", preferredStyle: .alert)
        let spinnerIndicator = UIActivityIndicatorView(style: .large)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        alertController.dismiss(animated: true, completion: nil)
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        view2.backgroundColor = .black
        view.addSubview(view2)
        let vc = storyboard?.instantiateViewController(withIdentifier: "overview") as! OverviewViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    func setupNavi() {
        if productsDetail.detailBasic.modelName.count != 1 {
            self.title = "Chọn \(child2) phù hợp"
        } else {
            title = ""
        }
    }
    func createButton1() {
        let button = UIButton(frame: CGRect(x: view.center.x - CGFloat(sizeBT_margin[0]),
                                             y: view.frame.width + newCompare.frame.height + CGFloat(sizeBT_margin[2] * 2 + sizeBT_margin[1] * 0),
                                             width: CGFloat(sizeBT_margin[0] * 2),
                                             height: CGFloat(sizeBT_margin[1])))
        button.layer.cornerRadius = 26
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.configuration = createConfig1()
        button.addTarget(self, action: #selector(taptoButton1), for: .touchUpInside)
        view1.addSubview(button)
    }
    func createConfig1() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.baseBackgroundColor = .blue
        config.title = "\(productsDetail.detailBasic.specsTitle[0])"
        config.subtitle = "Giá từ \(productsDetail.detailBasic.cost[0])00.000Vnđ"
        config.titleAlignment = .center
        return config
    }
    @objc func taptoButton1(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "overview") as! OverviewViewController
        test = 1
        navigationController?.pushViewController(vc, animated: true)
    }
    func createButton2() {
        let button = UIButton(frame: CGRect(x: view.center.x - CGFloat(sizeBT_margin[0]),
                                             y: view.frame.width + newCompare.frame.height + CGFloat(sizeBT_margin[2] * 3 + sizeBT_margin[1] * 1),
                                             width: CGFloat(sizeBT_margin[0] * 2),
                                             height: CGFloat(sizeBT_margin[1])))
        button.layer.cornerRadius = 26
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.configuration = createConfig2()
        button.addTarget(self, action: #selector(taptoButton2), for: .touchUpInside)
        view1.addSubview(button)
    }
    func createConfig2() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.baseBackgroundColor = .blue
        config.title = "\(productsDetail.detailBasic.specsTitle[1])"
        config.subtitle = "Giá từ \(productsDetail.detailBasic.cost[1])00.000Vnđ"
        config.titleAlignment = .center
        return config
    }
    @objc func taptoButton2(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "overview") as! OverviewViewController
        test = 2
        navigationController?.pushViewController(vc, animated: true)
    }
    func createButton3() {
        let button = UIButton(frame: CGRect(x: view.center.x - CGFloat(sizeBT_margin[0]),
                                             y: view.frame.width + newCompare.frame.height + CGFloat(sizeBT_margin[2] * 4 + sizeBT_margin[1] * 2),
                                             width: CGFloat(sizeBT_margin[0] * 2),
                                             height: CGFloat(sizeBT_margin[1])))
        button.layer.cornerRadius = 26
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.configuration = createConfig3()
        button.addTarget(self, action: #selector(taptoButton3), for: .touchUpInside)
        view1.addSubview(button)
    }
    func createConfig3() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.baseBackgroundColor = .blue
        config.title = "\(productsDetail.detailBasic.specsTitle[2])"
        config.subtitle = "Giá từ \(productsDetail.detailBasic.cost[2])00.000Vnđ"
        config.titleAlignment = .center
        return config
    }
    @objc func taptoButton3(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "overview") as! OverviewViewController
        test = 3
        navigationController?.pushViewController(vc, animated: true)
    }
    func createButton4() {
        let button = UIButton(frame: CGRect(x: view.center.x - CGFloat(sizeBT_margin[0]),
                                             y: view.frame.width + newCompare.frame.height + CGFloat(sizeBT_margin[2] * 5 + sizeBT_margin[1] * 3),
                                             width: CGFloat(sizeBT_margin[0] * 2),
                                             height: CGFloat(sizeBT_margin[1])))
        button.layer.cornerRadius = 26
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.configuration = createConfig4()
        button.addTarget(self, action: #selector(taptoButton4), for: .touchUpInside)
        view1.addSubview(button)
    }
    func createConfig4() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.baseBackgroundColor = .blue
        config.title = "\(productsDetail.detailBasic.specsTitle[3])"
        config.subtitle = "Giá từ \(productsDetail.detailBasic.cost[3])00.000Vnđ"
        config.titleAlignment = .center
        return config
    }
    @objc func taptoButton4(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "overview") as! OverviewViewController
        test = 4
        navigationController?.pushViewController(vc, animated: true)
    }
    func createButton5() {
        let button = UIButton(frame: CGRect(x: view.center.x - CGFloat(sizeBT_margin[0]),
                                             y: view.frame.width + newCompare.frame.height + CGFloat(sizeBT_margin[2] * 6 + sizeBT_margin[1] * 4),
                                             width: CGFloat(sizeBT_margin[0] * 2),
                                             height: CGFloat(sizeBT_margin[1])))
        button.layer.cornerRadius = 26
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.configuration = createConfig5()
        button.addTarget(self, action: #selector(taptoButton5), for: .touchUpInside)
        view1.addSubview(button)
    }
    func createConfig5() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.baseBackgroundColor = .blue
        config.title = "\(productsDetail.detailBasic.specsTitle[4])"
        config.subtitle = "Giá từ \(productsDetail.detailBasic.cost[4])00.000Vnđ"
        config.titleAlignment = .center
        return config
    }
    @objc func taptoButton5(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "overview") as! OverviewViewController
        test = 5
        navigationController?.pushViewController(vc, animated: true)
    }
    func createButton6() {
        let button = UIButton(frame: CGRect(x: view.center.x - CGFloat(sizeBT_margin[0]),
                                             y: view.frame.width + newCompare.frame.height + CGFloat(sizeBT_margin[2] * 7 + sizeBT_margin[1] * 5),
                                             width: CGFloat(sizeBT_margin[0] * 2),
                                             height: CGFloat(sizeBT_margin[1])))
        button.layer.cornerRadius = 26
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.configuration = createConfig6()
        button.addTarget(self, action: #selector(taptoButton6), for: .touchUpInside)
        view1.addSubview(button)
    }
    func createConfig6() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.baseBackgroundColor = .blue
        config.title = "\(productsDetail.detailBasic.specsTitle[5])"
        config.subtitle = "Giá từ \(productsDetail.detailBasic.cost[5])00.000Vnđ"
        config.titleAlignment = .center
        return config
    }
    @objc func taptoButton6(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "overview") as! OverviewViewController
        test = 6
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
    }
    func removeAllDataOnProductsDetail() {
        productsDetail.detailBasic.fullName = String()
        productsDetail.detailBasic.cost.removeAll()
        productsDetail.detailBasic.heightImageOver.removeAll()
        productsDetail.detailBasic.heightImageSpecs.removeAll()
        productsDetail.detailBasic.widthImageOver.removeAll()
        productsDetail.detailBasic.widthImageSpecs.removeAll()
        productsDetail.detailBasic.ratting.removeAll()
        productsDetail.detailBasic.imageCompare.removeAll()
        productsDetail.detailBasic.imageOverview.removeAll()
        productsDetail.detailBasic.imageSpecs.removeAll()
        productsDetail.detailBasic.modelName.removeAll()
        productsDetail.detailBasic.specsTitle.removeAll()
        productsDetail.detailBasic.statusProducts.removeAll()
        productsDetail.detailBasic.numberImageAllColor.removeAll()
        productsDetail.detailBasic.numberImagePerColor.removeAll()
        productsDetail.detailBasic.numberOfCmt.removeAll()
        productsDetail.imageProducts.imageProducts1.removeAll()
        productsDetail.imageProducts.imageProducts2.removeAll()
        productsDetail.imageProducts.imageProducts3.removeAll()
        productsDetail.imageProducts.imageProducts4.removeAll()
        productsDetail.imageProducts.imageProducts5.removeAll()
        productsDetail.imageProducts.imageProducts6.removeAll()
        productsDetail.tutorial.tutorial1.removeAll()
        productsDetail.tutorial.tutorial2.removeAll()
        productsDetail.tutorial.tutorial3.removeAll()
        productsDetail.tutorial.tutorial4.removeAll()
        productsDetail.tutorial.tutorial5.removeAll()
        productsDetail.tutorial.tutorial6.removeAll()
        let int = [0, 1, 2, 3, 4, 5]
        for i in int {
            productsDetail.option1[i].option.removeAll()
            productsDetail.option1[i].cost.removeAll()
            productsDetail.option2[i].option.removeAll()
            productsDetail.option2[i].cost.removeAll()
            productsDetail.option3[i].option.removeAll()
            productsDetail.option3[i].cost.removeAll()
            productsDetail.option4[i].option.removeAll()
            productsDetail.option4[i].cost.removeAll()
            productsDetail.option5[i].option.removeAll()
            productsDetail.option5[i].cost.removeAll()
            productsDetail.option6[i].option.removeAll()
            productsDetail.option6[i].cost.removeAll()
        }
    }
}
extension CompareViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsDetail.detailBasic.imageCompare.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollec.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CompareImageCollectionViewCell
        cell.imageCompare.sd_setImage(with: URL(string: productsDetail.detailBasic.imageCompare[indexPath.row]))
        cell.imageCompare.frame.size.height = view.frame.width
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollec.frame.width, height: imageCollec.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

