//
//  NewsTableViewCell.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 22/03/2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var timeNews: UILabel!
    @IBOutlet weak var viewNews: UIButton!
    @IBOutlet weak var cmtNews: UIButton!
    @IBOutlet weak var dislikeNews: UIButton!
    @IBOutlet weak var likeNews: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cmtNews.addTarget(self, action: #selector(tapToCmt), for: .touchUpInside)
        
        dislikeNews.tintColor = .lightGray
        dislikeNews.addTarget(self, action: #selector(tapToDislike), for: .touchUpInside)
        
        likeNews.tintColor = .lightGray
        likeNews.addTarget(self, action: #selector(tapToLike), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @objc func tapToCmt() {
        print("Chuyển sang màn hình bình luận")
    }
    @objc func tapToDislike() {
        if dislikeNews.tintColor == .lightGray && likeNews.tintColor == .lightGray {
            dislikeNews.tintColor = .blue
            switch dislikeNews.currentTitle {
            case "9999":
                dislikeNews.setTitle("1vạn", for: .normal)
            default:
                if Int(dislikeNews.currentTitle!)! >= 0 && Int(dislikeNews.currentTitle!)! < 9999 {
                    dislikeNews.setTitle(String(Int(dislikeNews.currentTitle!)! + 1), for: .normal)
                } else {
                }
            }
        } else if dislikeNews.tintColor == .blue && likeNews.tintColor == .lightGray {
            dislikeNews.tintColor = .lightGray
            switch dislikeNews.currentTitle {
            case "1":
                dislikeNews.setTitle("0", for: .normal)
            default:
                if Int(dislikeNews.currentTitle!)! > 1 && Int(dislikeNews.currentTitle!)! <= 9999 {
                    dislikeNews.setTitle(String(Int(dislikeNews.currentTitle!)! - 1), for: .normal)
                } else {
                }
            }
        } else if dislikeNews.tintColor == .lightGray && likeNews.tintColor == .blue {
            dislikeNews.tintColor = .blue
            likeNews.tintColor = .lightGray
            switch dislikeNews.currentTitle {
            case "9999":
                dislikeNews.setTitle("1vạn", for: .normal)
            default:
                if Int(dislikeNews.currentTitle!)! >= 0 && Int(dislikeNews.currentTitle!)! < 9999 {
                    dislikeNews.setTitle(String(Int(dislikeNews.currentTitle!)! + 1), for: .normal)
                } else {
                }
            }
            switch likeNews.currentTitle {
            case "1":
                likeNews.setTitle("0", for: .normal)
            default:
                if Int(likeNews.currentTitle!)! > 1 && Int(likeNews.currentTitle!)! <= 9999 {
                    likeNews.setTitle(String(Int(likeNews.currentTitle!)! - 1), for: .normal)
                } else {
                }
            }
        }
    }
    @objc func tapToLike() {
        if likeNews.tintColor == .lightGray && dislikeNews.tintColor == .lightGray {
            likeNews.tintColor = .blue
            switch likeNews.currentTitle {
            case "9999":
                likeNews.setTitle("1vạn", for: .normal)
            default:
                if Int(likeNews.currentTitle!)! >= 0 && Int(likeNews.currentTitle!)! < 9999 {
                    likeNews.setTitle(String(Int(likeNews.currentTitle!)! + 1), for: .normal)
                } else {
                }
            }
        } else if likeNews.tintColor == .blue && dislikeNews.tintColor == .lightGray {
            likeNews.tintColor = .lightGray
            switch likeNews.currentTitle {
            case "1":
                likeNews.setTitle("0", for: .normal)
            default:
                if Int(likeNews.currentTitle!)! > 1 && Int(likeNews.currentTitle!)! <= 9999 {
                    likeNews.setTitle(String(Int(likeNews.currentTitle!)! - 1), for: .normal)
                } else {
                }
            }
        } else if likeNews.tintColor == .lightGray && dislikeNews.tintColor == .blue {
            likeNews.tintColor = .blue
            dislikeNews.tintColor = .lightGray
            switch likeNews.currentTitle {
            case "9999":
                likeNews.setTitle("1vạn", for: .normal)
            default:
                if Int(likeNews.currentTitle!)! >= 0 && Int(likeNews.currentTitle!)! < 9999 {
                    likeNews.setTitle(String(Int(likeNews.currentTitle!)! + 1), for: .normal)
                } else {
                }
            }
            switch dislikeNews.currentTitle {
            case "1":
                dislikeNews.setTitle("0", for: .normal)
            default:
                if Int(dislikeNews.currentTitle!)! > 1 && Int(dislikeNews.currentTitle!)! <= 9999 {
                    dislikeNews.setTitle(String(Int(dislikeNews.currentTitle!)! - 1), for: .normal)
                } else {
                }
            }
        }
    }
}
