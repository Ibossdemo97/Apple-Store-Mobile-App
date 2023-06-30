//
//  NewsViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 22/03/2023.
//

import UIKit
import SDWebImage
import FirebaseDatabase

var detailNews = (DetailNews(newsLink: [String](), newsImage: [String](), newsTitle: [String](), newsTime: [String](), newsView: [String](), newsCmt: [String](), newsDislike: [String](), newsLike: [String]()))
class NewsViewController: UIViewController {

    @IBOutlet weak var newsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTable.dataSource = self
        newsTable.delegate = self
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        newsTable.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        newsTable.reloadData()
        takeDataNews()
    }
    func takeDataNews() {
        var ref: DatabaseReference!
        ref = Database.database().reference().child("detailNews")
        ref.observe(.value) { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else { return }
            let newsLink = data["newsLink"] as? [String] ?? [String]()
            let newsImage = data["newsImage"] as? [String] ?? [String]()
            let newsTitle = data["newsTitle"] as? [String] ?? [String]()
            let newsTime = data["newsTime"] as? [String] ?? [String]()
            let newsView = data["newsView"] as? [String] ?? [String]()
            let newsCmt = data["newsCmt"] as? [String] ?? [String]()
            let newsDislike = data["newsDislike"] as? [String] ?? [String]()
            let newsLike = data["newsLike"] as? [String] ?? [String]()
            
            detailNews.newsLink = newsLink
            detailNews.newsImage = newsImage
            detailNews.newsTitle = newsTitle
            detailNews.newsTime = newsTime
            detailNews.newsView = newsView
            detailNews.newsCmt = newsCmt
            detailNews.newsDislike = newsDislike
            detailNews.newsLike = newsLike
        }
    }
}
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailNews.newsTitle.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: "\(detailNews.newsLink[indexPath.row])") else { return }
        UIApplication.shared.open(url)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTable.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.imageNews.sd_setImage(with: URL(string: detailNews.newsImage[indexPath.row]))
        cell.titleNews.text = detailNews.newsTitle[indexPath.row]
        cell.timeNews.text = detailNews.newsTime[indexPath.row]
        cell.viewNews.setTitle(detailNews.newsView[indexPath.row], for: .normal)
        cell.cmtNews.setTitle(detailNews.newsCmt[indexPath.row], for: .normal)
        cell.dislikeNews.setTitle(detailNews.newsDislike[indexPath.row], for: .normal)
        cell.likeNews.setTitle(detailNews.newsLike[indexPath.row], for: .normal)
        cell.dislikeNews.tag = indexPath.row
        cell.likeNews.tag = indexPath.row
        return cell
    }
}
struct DetailNews {
    var newsLink = [String]()
    var newsImage = [String]()
    var newsTitle = [String]()
    var newsTime = [String]()
    var newsView = [String]()
    var newsCmt = [String]()
    var newsDislike = [String]()
    var newsLike = [String]()
}
