//
//  SellectedMealsViewController.swift
//  TurkishCuisineOne
//
//  Created by Shohzod Rajabov on 05/12/21.
//

import UIKit
import SnapKit

class SellectedMealsViewController: UIViewController, UICollectionViewDelegateFlowLayout{

    var topView = UIView()
    var titleLbl = UILabel()
    var menuBtn = UIButton()
    var collectionView: UICollectionView?
    let defaults = UserDefaults.standard
    let padding:CGFloat = 10
    var sellectedMeals = [Meal]()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        createTopView()
        
        
        let layout = UICollectionViewFlowLayout()
        layoutSettings(layout)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.register(SelectedCell.self, forCellWithReuseIdentifier: "SelectedCell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .clear
        view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ make in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        })
       
        
    }

    fileprivate func layoutSettings(_ layout: UICollectionViewFlowLayout) {
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
    
    @objc func backClicked(){        
//        dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func createTopView(){
        view.addSubview(topView)
        topView.backgroundColor = UIColor(red: 248/255, green: 60/255, blue: 10/255, alpha: 1.00)
        topView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        })
        
        topView.addSubview(menuBtn)
        menuBtn.backgroundColor = .clear
        menuBtn.tintColor = .white
        menuBtn.clipsToBounds = true
        menuBtn.contentMode = .scaleAspectFill
        menuBtn.setImage(UIImage(named: "left-arrow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        menuBtn.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        menuBtn.snp.makeConstraints({ make in
            make.bottom.equalTo(-10)
            make.left.equalTo(20)
            make.height.width.equalTo(21)
        })
        
        topView.addSubview(titleLbl)
        titleLbl.backgroundColor = .clear
        titleLbl.textColor = .white
        titleLbl.textAlignment = .center
        titleLbl.text = "Избранное"
        titleLbl.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        titleLbl.snp.makeConstraints({ make in
            make.bottom.equalTo(-10)
            make.left.equalTo(menuBtn.snp.right)
            make.right.equalTo(-45)
        })
    }
    
    
    
 
}

extension SellectedMealsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (defaults.array(forKey: "num") as? [Int])?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedCell", for: indexPath) as! SelectedCell
        if let selIn = defaults.array(forKey: "num") as? [Int] {
            let obj = sellectedMeals[selIn[indexPath.row]]
            cell.starBtn.setImage(UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
            cell.nameLbl.text = obj.name
            cell.bgView.sd_setImage(with: URL(string: obj.img_url ?? ""), placeholderImage: UIImage(named: "placeholder"))
        }
        cell.starBtn.addTarget(self, action: #selector(starClicked(sender:)), for: .touchUpInside)
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
        if let selIn = defaults.array(forKey: "num") as? [Int] {
            controller.index = selIn[indexPath.row]
        }
        controller.items = sellectedMeals
        present(controller, animated: true)
    }
    
    @objc func starClicked(sender: UIButton){
        if var numArr = defaults.array(forKey: "num"){
                numArr = numArr.filter(){$0 as! Int != numArr[sender.tag] as! Int}
                defaults.set(numArr, forKey: "num")
                collectionView?.reloadData()
            
        }
        print("SenderTag: \(sender.tag)  ", defaults.array(forKey: "num")!)
    }

}
