//
//  HelpViewController.swift
//  superauto
//
//  Created by Luyện Hà Luyện on 03/12/2022.
//

import UIKit
import Foundation

class HelpViewController: UIViewController {

    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var popupButton: UIButton!

    var listHelp: ListHelp?

    override func viewDidLoad() {
        super.viewDidLoad()

        parseHelpJSON()
        setPopUpButton()
        
    }
    private func parseHelpJSON() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json")
        else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            listHelp = try JSONDecoder().decode(ListHelp.self, from: jsonData)
        } catch {
            print("🥶🥶🥶🥶Error: \(error)")
        }
    }
    func setPopUpButton(){
        let optionClosure = {(action: UIAction) in
            print(action.title)
        }
        popupButton.menu = UIMenu(children: [
            UIAction(title: (self.listHelp?.help[0].city)! , state: .off, handler: {(_) in
                self.text.text = self.listHelp?.help[0].content
                }),
            UIAction(title: (self.listHelp?.help[1].city)!, state: .off, handler: {(_) in
                self.text.text = self.listHelp?.help[1].content
            }),
            UIAction(title: (self.listHelp?.help[2].city)!, state: .off, handler:  {(_) in
                self.text.text = self.listHelp?.help[2].content
            }),
            UIAction(title: (self.listHelp?.help[3].city)!, state: .off, handler:  {(_) in
                self.text.text = self.listHelp?.help[3].content
            }),
            UIAction(title: (self.listHelp?.help[4].city)!, state: .off, handler:  {(_) in
                self.text.text = self.listHelp?.help[4].content
            }),
            UIAction(title: (self.listHelp?.help[5].city)!, state: .off, handler:  {(_) in
                self.text.text = self.listHelp?.help[5].content
            }),
            UIAction(title: (self.listHelp?.help[6].city)!, state: .off , handler:  {(_) in
                self.text.text = self.listHelp?.help[6].content
            }),
        ])
        popupButton.showsMenuAsPrimaryAction = true
        popupButton.changesSelectionAsPrimaryAction = true
    }
        
    @IBAction func selecButton(_ sender: UIButton) {
    }
}
struct ListHelp: Codable {
    let help: [DetailHelp]
}
struct DetailHelp: Codable {
    let city: String
    let content: String
}
