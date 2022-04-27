//
//  MealsCollectionViewCell.swift
//  TurkishCuisineOne
//
//  Created by Shohzod Rajabov on 02/12/21.
//

import UIKit
import SnapKit

class MealsCell: UICollectionViewCell {
    
    let bgView = UIImageView()
    let nameLbl = UILabel()
    let starBtn = UIButton()
    var gradientView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        
        contentView.addSubview(bgView)
        bgView.backgroundColor = .black
//        bgView.image = UIImage(named: "nature")
        bgView.contentMode = .scaleAspectFill
        bgView.clipsToBounds = true
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        gradientView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        bgView.addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.frame.size = self.gradientView.frame.size
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.withAlphaComponent(1).cgColor]
        gradientView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(starBtn)
        starBtn.contentMode = .scaleAspectFill
        starBtn.clipsToBounds = true
        starBtn.setImage(UIImage(named: "star2")?.withRenderingMode(.alwaysTemplate), for: .normal)
        starBtn.tintColor = .white
        starBtn.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.height.width.equalTo(25)
            
        }
        
        contentView.addSubview(nameLbl)
        nameLbl.textColor = .white
        nameLbl.textAlignment = .center
        nameLbl.backgroundColor = .clear
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        nameLbl.numberOfLines = 0
        nameLbl.sizeToFit()
        nameLbl.snp.makeConstraints { make in
            make.bottom.equalTo(-5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
