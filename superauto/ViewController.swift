//
//  ViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 29/11/2022.
//

import UIKit

//struct ProductsDetail {
//    var detailBasic = DetailBasic(  fullName: "Macbook Air",
//                                    modelName: ["M1", "M2", "M2"],
//                                    statusProducts: ["Hết hàng", "Còn hàng", "Còn hàng"],
//                                    imageCompare: ["AirM1vM2", "AirM1vsM2", "GPU8Cvs10C", "M2Chip"],
//                                    imageOverview: ["MacBookAirM1Overview", "MacBookAirM2Overview", "MacBookAirM2Overview"],
//                                    imageSpecs: ["AirM1Specs", "AirM2Specs", "AirM2Specs"],
//                                    specsTitle: ["CPU M1 với 8-CPU và 7-GPU", "CPU M2 với 8-CPU và 8-GPU", "CPU M2 với 8-CPU và 10-GPU"],
//                                    cost: [25.0, 30.0, 36.5],
//                                    ratting: [9.7, 8.2, 7.7],
//                                    numberOfCmt: [123, 34, 12],
//                                    numberImageAllColor: [1, 1, 1 ],
//                                    numberImagePerColor: [5, 6, 6],
//                                    widthImageOver: [677, 683, 683],
//                                    heightImageOver: [10339, 3088, 3088],
//                                    widthImageSpecs: [1003, 995, 995],
//                                    heightImageSpecs: [7173, 8710, 8710])
//
//    var imageProducts = ImageProducts(imageProducts1: ["AirM1AllColor1",
//                                                       "AirM1Space1",
//                                                       "AirM1Space2",
//                                                       "AirM1Space3",
//                                                       "AirM1Space4",
//                                                       "AirM1Space5",
//                                                       "AirM1Silver1",
//                                                       "AirM1Silver2",
//                                                       "AirM1Silver3",
//                                                       "AirM1Silver4",
//                                                       "AirM1Silver5",
//                                                       "AirM1Gold1",
//                                                       "AirM1Gold2",
//                                                       "AirM1Gold3",
//                                                       "AirM1Gold4",
//                                                       "AirM1Gold5"],
//                                      imageProducts2: ["AirM2AllColor1",
//                                                       "AirM2Grey1",
//                                                       "AirM2Grey2",
//                                                       "AirM2Grey3",
//                                                       "AirM2Grey4",
//                                                       "AirM2Grey5",
//                                                       "AirM2Grey6",
//                                                       "AirM2Midnight1",
//                                                       "AirM2Midnight2",
//                                                       "AirM2Midnight3",
//                                                       "AirM2Midnight4",
//                                                       "AirM2Midnight5",
//                                                       "AirM2Midnight6",
//                                                       "AirM2Grey1",
//                                                       "AirM2Grey2",
//                                                       "AirM2Grey3",
//                                                       "AirM2Grey4",
//                                                       "AirM2Grey5",
//                                                       "AirM2Grey6",
//                                                       "AirM2Gold1",
//                                                       "AirM2Gold2",
//                                                       "AirM2Gold3",
//                                                       "AirM2Gold4",
//                                                       "AirM2Gold5",
//                                                       "AirM2Gold6"],
//                                      imageProducts3: ["AirM2AllColor1",
//                                                       "AirM2Grey1",
//                                                       "AirM2Grey2",
//                                                       "AirM2Grey3",
//                                                       "AirM2Grey4",
//                                                       "AirM2Grey5",
//                                                       "AirM2Grey6",
//                                                       "AirM2Midnight1",
//                                                       "AirM2Midnight2",
//                                                       "AirM2Midnight3",
//                                                       "AirM2Midnight4",
//                                                       "AirM2Midnight5",
//                                                       "AirM2Midnight6",
//                                                       "AirM2Grey1",
//                                                       "AirM2Grey2",
//                                                       "AirM2Grey3",
//                                                       "AirM2Grey4",
//                                                       "AirM2Grey5",
//                                                       "AirM2Grey6",
//                                                       "AirM2Gold1",
//                                                       "AirM2Gold2",
//                                                       "AirM2Gold3",
//                                                       "AirM2Gold4",
//                                                       "AirM2Gold5",
//                                                       "AirM2Gold6"],
//                                      imageProducts4: [String](),
//                                      imageProducts5: [String](),
//                                      imageProducts6: [String]())
//
//    var tutorial = Tutorial (tutorial1: ["Chọn màu sắc mà bạn yêu thích.",
//                                         "Chọn dung lượng RAM phù hợp với bạn.",
//                                         "Chọn dung lượng bộ nhớ trong phù hợp với bạn.",
//                                         "Bạn muốn mua AppleCare chứ?"],
//                             tutorial2: ["Chọn màu sắc mà bạn yêu thích.",
//                                         "Chọn dung lượng RAM phù hợp với bạn.",
//                                         "Chọn dung lượng bộ nhớ trong phù hợp với bạn.",
//                                         "Chọn bộ sạc phù hợp với bạn.",
//                                         "Bạn muốn mua AppleCare chứ?"],
//                             tutorial3: ["Chọn màu sắc mà bạn yêu thích.",
//                                         "Chọn dung lượng RAM phù hợp với bạn.",
//                                         "Chọn dung lượng bộ nhớ trong phù hợp với bạn.",
//                                         "Chọn bộ sạc phù hợp với bạn.",
//                                         "Bạn muốn mua AppleCare chứ?"],
//                             tutorial4: [String](),
//                             tutorial5: [String](),
//                             tutorial6: [String]())
//
//    var option1 = [ModelsOptionDetal(option: ["Xám", "Bạc", "Vàng"], cost: [0.0, 0.0, 0.0]),
//                   ModelsOptionDetal(option: ["Xám", "Xanh", "Bạc", "Vàng"], cost: [0.0, 0.0, 0.0, 0.0]),
//                   ModelsOptionDetal(option: ["Xám", "Xanh", "Bạc", "Vàng"], cost: [0.0, 0.0, 0.0, 0.0]),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]())]
//    var option2 = [ModelsOptionDetal(option: ["8GB", "16GB"], cost: [0.0, 5.0]),
//                   ModelsOptionDetal(option: ["8GB", "16GB", "24GB"], cost: [0.0, 5.0, 10.0]),
//                   ModelsOptionDetal(option: ["8GB", "16GB", "24GB"], cost: [0.0, 5.0, 10.0]),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]())]
//    var option3 = [ModelsOptionDetal(option: ["256GB", "512GB", "1TB", "2TB"], cost: [0.0, 5.0, 10.0, 20.0]),
//                   ModelsOptionDetal(option: ["256GB", "512GB", "1TB", "2TB"], cost: [0.0, 5.0, 10.0, 20.0]),
//                   ModelsOptionDetal(option: ["256GB", "512GB", "1TB", "2TB"], cost: [0.0, 5.0, 10.0, 20.0]),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]())]
//    var option4 = [ModelsOptionDetal(option: ["Không AppleCare+", "AppleCare+ 1năm", "AppleCare+ 3năm"], cost: [0.0, 1.7, 4.7]),
//                   ModelsOptionDetal(option: ["Sạc 1 cổng 30W", "Sạc 2 cổng 35W", "Sạc 1 cổng 65W"], cost: [0.0, 0.5, 0.5]),
//                   ModelsOptionDetal(option: ["Sạc 1 cổng 30W", "Sạc 2 cổng 35W", "Sạc 1 cổng 65W"], cost: [0.0, 0.5, 0.5]),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]())]
//    var option5 = [ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: ["Không AppleCare+", "AppleCare+ 1năm", "AppleCare+ 3năm"], cost: [0.0, 1.9, 5.5]),
//                   ModelsOptionDetal(option: ["Không AppleCare+", "AppleCare+ 1năm", "AppleCare+ 3năm"], cost: [0.0, 1.9, 5.5]),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]())]
//    var option6 = [ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]()),
//                   ModelsOptionDetal(option: [String](), cost: [Double]())]
//}
struct ProductsDetail {
    var detailBasic = DetailBasic(  fullName: String(),
                                    modelName: [String](),
                                    statusProducts: [String](),
                                    imageCompare: [String](),
                                    imageOverview: [String](),
                                    imageSpecs: [String](),
                                    specsTitle: [String](),
                                    cost: [Double](),
                                    ratting: [Double](),
                                    numberOfCmt: [Int](),
                                    numberImageAllColor: [Int](),
                                    numberImagePerColor: [Int](),
                                    widthImageOver: [Double](),
                                    heightImageOver: [Double](),
                                    widthImageSpecs: [Double](),
                                    heightImageSpecs: [Double]())

    var imageProducts = ImageProducts(imageProducts1: [String](),
                                      imageProducts2: [String](),
                                      imageProducts3: [String](),
                                      imageProducts4: [String](),
                                      imageProducts5: [String](),
                                      imageProducts6: [String]())

    var tutorial = Tutorial (tutorial1: [String](),
                             tutorial2: [String](),
                             tutorial3: [String](),
                             tutorial4: [String](),
                             tutorial5: [String](),
                             tutorial6: [String]())

    var option1 = [ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]())]
    var option2 = [ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]())]
    var option3 = [ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]())]
    var option4 = [ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]())]
    var option5 = [ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]())]
    var option6 = [ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]()),
                   ModelsOptionDetal(option: [String](), cost: [Double]())]
}
var productsDetail = ProductsDetail()

class ViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
struct DetailBasic {
    var fullName: String
    var modelName: [String]
    var statusProducts: [String]
    var imageCompare: [String]
    var imageOverview: [String]
    var imageSpecs: [String]
    var specsTitle: [String]
    var cost: [Double]
    var ratting: [Double]
    var numberOfCmt: [Int]
    var numberImageAllColor: [Int]
    var numberImagePerColor: [Int]
    var widthImageOver:[Double]
    var heightImageOver:[Double]
    var widthImageSpecs:[Double]
    var heightImageSpecs:[Double]
}
struct ImageProducts {
    var imageProducts1: [String]
    var imageProducts2: [String]
    var imageProducts3: [String]
    var imageProducts4: [String]
    var imageProducts5: [String]
    var imageProducts6: [String]
}
struct Tutorial {
    var tutorial1: [String]
    var tutorial2: [String]
    var tutorial3: [String]
    var tutorial4: [String]
    var tutorial5: [String]
    var tutorial6: [String]
}
struct ModelOption {
    var modelOption: [ModelsOptionDetal]
}
struct ModelsOptionDetal {
    var option: [String]
    var cost: [Double]
}
