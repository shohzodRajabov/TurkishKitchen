//
//  ViewController.swift
//  TurkishCuisineOne
//
//  Created by Shohzod Rajabov on 01/12/21.
//

import UIKit
import SnapKit
import SDWebImage
import SideMenu


class ViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    var topView = UIView()
    var titleLbl = UILabel()
    var menuBtn = UIButton()
    var collectionView: UICollectionView?
    let defaults = UserDefaults.standard
    let padding:CGFloat = 10
    var meals = [Meal]()

    var menu: SideMenuNavigationController?
    let menuController = MenuTableViewController()
    
    
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.7)
        createTopView()
        setSideMenu()
        
        
        let layout = UICollectionViewFlowLayout()
        layoutSettings(layout)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.register(MealsCell.self, forCellWithReuseIdentifier: "MealsCell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .clear
        view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ make in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        })
        
        guard let path = Bundle.main.path(forResource: "turk_cuisine", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        if let data = try? Data(contentsOf: url) {
           parse(data: data)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.collectionView?.reloadData()
    }
    func parse(data: Data) {
        do{
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] {
                for js in json{
                    let obj = Meal.init(js)
                    meals.append(obj)
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }

    fileprivate func layoutSettings(_ layout: UICollectionViewFlowLayout) {
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
    
    func setSideMenu(){
        menu = SideMenuNavigationController(rootViewController: menuController)
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    
    @objc func menuClicked(){
//        menuController.mealsArr = meals
        menuController.onChange = { [weak self] son in
            self?.openMenuItems(son)
        }
        present(menu!, animated: true)
    }
    
    func openMenuItems(_ index:Int){
        if index == 0 {
            dismiss(animated: true)
        }
        if index == 1{
            let controller = SellectedMealsViewController()
            controller.sellectedMeals = self.meals
            self.navigationController?.pushViewController(controller, animated: true)
            print("index = ", index)
        }
        if index == 2{
            print("Share function")
        }
        if index == 3{
            print("Rate")
        }
    }
    
    func createTopView(){
        view.addSubview(topView)
        topView.backgroundColor = UIColor(red: 248/255, green: 60/255, blue: 10/255, alpha: 1.00) // UIColor(red: 0.77, green: 0.4, blue: 0.6, alpha: 1.00)
        topView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(67)
        })
        topView.addSubview(menuBtn)
        menuBtn.backgroundColor = .clear
        menuBtn.tintColor = .white
        menuBtn.clipsToBounds = true
        menuBtn.contentMode = .scaleAspectFill
        menuBtn.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        menuBtn.addTarget(self, action: #selector(menuClicked), for: .touchUpInside)
        menuBtn.snp.makeConstraints({ make in
            make.bottom.equalTo(-10)
            make.left.equalTo(20)
            make.height.width.equalTo(21)
        })
        topView.addSubview(titleLbl)
        titleLbl.backgroundColor = .clear
        titleLbl.textColor = .white
        titleLbl.textAlignment = .center
        titleLbl.text = "Рецепты турецкой кухни"
        titleLbl.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLbl.snp.makeConstraints({ make in
            make.bottom.equalTo(-10)
            make.left.equalTo(menuBtn.snp.right).offset(5)
            make.right.equalTo(-45)
        })
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let obj = meals[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealsCell", for: indexPath) as! MealsCell
        cell.nameLbl.text = obj.name
        cell.bgView.sd_setImage(with: URL(string: obj.img_url ?? ""), placeholderImage: UIImage(named: "placeholder"))
        if let numArr = defaults.array(forKey: "num"){
            if numArr.contains(where: {$0 as? Int == indexPath.row}) {
                cell.starBtn.setImage(UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
            } else {
                cell.starBtn.setImage(UIImage(named: "star2")?.withRenderingMode(.alwaysTemplate), for: .normal)
            }
        }
        cell.starBtn.addTarget(self, action: #selector(starClicked), for: .touchUpInside)
        cell.starBtn.tag = indexPath.row
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let topHeight = UIScreen.main.bounds.height - collectionView.bounds.height
        let width = (UIScreen.main.bounds.width - 3 * padding)/2.0
        let height = (UIScreen.main.bounds.height - topHeight - 5 * padding)/4.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = MealTabViewController()
        controller.modalPresentationStyle = .custom
        controller.index = indexPath.row
        controller.items = meals
        present(controller, animated: true)
    }
    
    @objc func starClicked(sender: UIButton){
        if defaults.array(forKey: "num") != nil {
            if var numArr = defaults.array(forKey: "num"){
                if numArr.contains(where: {$0 as? Int == sender.tag}) {
                    sender.setImage(UIImage(named: "star2")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    numArr = numArr.filter(){$0 as! Int != sender.tag}
                    defaults.set(numArr, forKey: "num")
                } else {
                    sender.setImage(UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    numArr.append(sender.tag)
                    defaults.set(numArr, forKey: "num")
                }
            }
        } else {
            var arr = [Int]()
            arr.append(sender.tag)
            sender.setImage(UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
            defaults.set(arr, forKey: "num")
        }
        
    }
    
}








