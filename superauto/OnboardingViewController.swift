//
//  OnboardingViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 13/02/2023.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore

class OnboardingViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBT: UIButton!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBT.titleLabel?.font = UIFont.systemFont(ofSize: 26)
                nextBT.setTitle("Bắt đầu", for: .normal)
            } else {
                nextBT.titleLabel?.font = UIFont.systemFont(ofSize: 26)
                nextBT.setTitle("Tiếp theo", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDataFromFirebase()
        setupView()
        
        collectionView.dataSource = self
        collectionView.delegate = self

    }

    @IBAction func clickNextBT(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let vc = storyboard?.instantiateViewController(identifier: "mainVC") as! MainViewController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    func resetFunc() {
        getDataFromFirebase()
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
            self.getDataFromFirebase()
            }
    }
    
    func setupView() {
        slides = [OnboardingSlide(titile: "Tận hưởng dịch vụ giao hàng tuyệt vời.", description: "Giao hàng trong hai giờ từ Apple Store, giao hàng miễn phí hoặc nhận hàng dễ dàng.", image: "boxtruck"),
                  OnboardingSlide(titile: "Trao đổi thiết bị của bạn để lấy một sản phẩm mới.", description: "Chỉ cần thêm một trao đổi khi bạn chọn một sản phẩm mới. Khi thiết bị của bạn đã được nhận và xác minh, chúng tôi sẽ khấu trừ vào phương thức thanh toán của bạn.", image: "trade"),
                  OnboardingSlide(titile: "Thanh toán toàn bộ hoặc thanh toán theo thời gian.", description: "Thanh toán với ưu đãi tối đa từ các hình thức thanh toán bạn lựa chọn.", image: "card"),
                  OnboardingSlide(titile: "Thêm một dòng khắc tuỳ chọn.", description: "Cá nhân hoá với dịch vụ khắc miễn phí biểu tượng cảm xúc, chữ, số,...", image: "love"),
                  OnboardingSlide(titile: "Tuỳ chỉnh sản phẩm của bạn.", description: "Tuỳ chỉnh máy Mac, phong cách Apple Watch của riêng bạn", image: "apple")
        ]
        pageControl.numberOfPages = slides.count
        nextBT.titleLabel?.font = UIFont.systemFont(ofSize: 26)
    }
    
    func getDataFromFirebase() {
        var ref: DatabaseReference!
        var ref1: DatabaseReference!
        let int = [0, 1, 2, 3, 4, 5, 6]
        for i in int {
            listPro[i].pro.removeAll()
            listImage[i].image.removeAll()
        }
        for i in listItem {
            ref = Database.database().reference().child("items")
            ref.child("\(i)").observe(.value) { (snapshot) in
                guard let data = snapshot.value as? [String] else { return }
                listPro[listItem.firstIndex(of: i)!].pro += data
            }
            ref1 = Database.database().reference().child("imageItems")
            ref1.child("\(i)").observe(.value) { (snapshot) in
                guard let data = snapshot.value as? [String] else { return }
                listImage[listItem.firstIndex(of: i)!].image += data
            }
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)

    }
    
}
