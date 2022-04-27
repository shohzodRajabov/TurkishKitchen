//
//  MealTabViewController.swift
//  TurkishCuisineOne
//
//  Created by Shohzod Rajabov on 03/12/21.
//

import UIKit
import SnapKit
import SDWebImage

class MealTabViewController: UIViewController {
    var topView = UIView()
    var titleLbl = UILabel()
    var backBtn = UIButton()
    var shareBtn = UIButton()
    let tableview = UITableView()
    
    var items = [Meal]()
    
    var index: Int = 0
    var imageHeight: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        createTopView()
       
        
        view.addSubview(tableview)
        tableview.backgroundColor = .black
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.register(MealCell.self, forCellReuseIdentifier: "MealCell")
        tableview.register(IngredientsCell.self, forCellReuseIdentifier: "IngredientsCell")
        tableview.register(StepsCell.self, forCellReuseIdentifier: "StepsCell")
        tableview.register(StepsImageCell.self, forCellReuseIdentifier: "StepsWithImageCell")
        
        tableview.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        
        
        
        
        
    }
    
    @objc func backClicked(){
        dismiss(animated: true)
    }
    
    @objc func shareClicked(){
//        dismiss(animated: true)
        let vc = UIActivityViewController(activityItems: ["https://apps.apple.com/app/apple-store/id1516163645"], applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = self.view
        self.present(vc, animated: true, completion: nil)
    }
    
    func createTopView(){
        view.addSubview(topView)
        topView.backgroundColor = UIColor(red: 248/255, green: 60/255, blue: 10/255, alpha: 1.00) // UIColor(red: 0.77, green: 0.4, blue: 0.6, alpha: 1.00)
        topView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        })
        
        topView.addSubview(backBtn)
        backBtn.backgroundColor = .clear
        backBtn.tintColor = .white
        backBtn.clipsToBounds = true
        backBtn.contentMode = .scaleAspectFill
        backBtn.setImage(UIImage(named: "left-arrow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backBtn.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        backBtn.snp.makeConstraints({ make in
            make.bottom.equalTo(-10)
            make.left.equalTo(20)
            make.height.width.equalTo(21)
        })
        
        topView.addSubview(shareBtn)
        shareBtn.backgroundColor = .clear
        shareBtn.tintColor = .white
        shareBtn.clipsToBounds = true
        shareBtn.contentMode = .scaleAspectFill
        shareBtn.setImage(UIImage(named: "share")?.withRenderingMode(.alwaysTemplate), for: .normal)
        shareBtn.addTarget(self, action: #selector(shareClicked), for: .touchUpInside)
        shareBtn.snp.makeConstraints({ make in
            make.bottom.equalTo(-10)
            make.right.equalTo(-20)
            make.height.width.equalTo(21)
        })
        
        topView.addSubview(titleLbl)
        titleLbl.backgroundColor = .clear
        titleLbl.textColor = .white
        titleLbl.textAlignment = .center
        titleLbl.text = items[index].name
        titleLbl.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLbl.snp.makeConstraints({ make in
            make.bottom.equalTo(-10)
            make.left.equalTo(backBtn.snp.right).offset(5)
            make.right.equalTo(shareBtn.snp.left).offset(-10)
        })
    }
}


extension MealTabViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return items[index].ingredients.count
        }
        return items[index].steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
//        cell.textLabel?.text = " cell.textLabel.text" + String(indexPath.row)
//        cell.detailTextLabel?.text = "cell.detailTextLabel?.text" + String(indexPath.row)
        
        let obj = items[index]
        if indexPath.section == 0 {
            let cell = tableview.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealCell
            cell.image.sd_setImage(with: URL(string: obj.img_url ?? ""), placeholderImage: UIImage(named: "placeholder"))
            cell.label.text = obj.desc
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableview.dequeueReusableCell(withIdentifier: "IngredientsCell", for: indexPath) as! IngredientsCell
            cell.label.text = obj.ingredients[indexPath.row].name
            return cell
        }
        if let img = obj.steps[indexPath.row].img {
            let cell = tableview.dequeueReusableCell(withIdentifier: "StepsWithImageCell", for: indexPath) as! StepsImageCell
            cell.image.sd_setImage(with: URL(string: img ), placeholderImage: UIImage(named: "placeholder"))
            cell.numLbl.text = String(indexPath.row + 1)
            cell.label.text = obj.steps[indexPath.row].name
            return cell
        }
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "StepsCell", for: indexPath) as! StepsCell
        cell.numLbl.text = String(indexPath.row + 1)
        cell.label.text = obj.steps[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        if section == 1 {
            return "Ингредиенты"
        }
        return "Шаги"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = .orange // UIColor(red: 0.87, green: 0.4, blue: 0.6, alpha: 1.00)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    
}
