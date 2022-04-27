//
//  MenuViewController.swift
//  TurkishCuisineOne
//
//  Created by Shohzod Rajabov on 01/12/21.
//

import UIKit


class MenuTableViewController: UITableViewController {
    var onChange:(_ index:Int)->() = { son in
        print(son)
    }
    let menuArr = ["Рецепты турецкой кухни", "Избранное", "Поделиться", "Оценить","Напишите нам"]
    let iconArr = ["dinner", "star", "share", "rate","email"]
    
//    var mealsArr = [Meal]()
//    var indexArr = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
    }
    
    func rateClicked(){
       
               

                
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.menuLbl.text = menuArr[indexPath.row]
        cell.icon.image = UIImage(named: iconArr[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            dismiss(animated: true)
            print("Menu Index = ", indexPath.row)
        }
        if indexPath.row == 1 {
            print("Menu Index = ", indexPath.row)
            dismiss(animated: false) {
                tableView.deselectRow(at: indexPath, animated: true)
                self.onChange(indexPath.row)
                
            }
        }
        
        if indexPath.row == 2 {
//            dismiss(animated: true)
            print("Menu Index = ", indexPath.row)
            let vc = UIActivityViewController(activityItems: ["https://apps.apple.com/app/apple-store/id1516163645"], applicationActivities: nil)
            vc.popoverPresentationController?.sourceView = self.view
            self.present(vc, animated: true, completion: nil)
            
        }
        
        if indexPath.row == 3 {
            print("Menu Index = ", indexPath.row)
            dismiss(animated: true) {
                if let url = URL(string: "https://apps.apple.com/app/apple-store/id1516163645") {
                      UIApplication.shared.open(url)
                   }
            }
        }
        
    }
}
