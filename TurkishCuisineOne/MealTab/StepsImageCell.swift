//
//  StepsWithImageCell.swift
//  TurkishCuisineOne
//
//  Created by Shohzod Rajabov on 03/12/21.
//

import UIKit

class StepsImageCell: UITableViewCell {
    
    let numLbl = UILabel()
    let label = UILabel()
    let image = UIImageView()
    let padding = 5

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .black
        
        contentView.addSubview(numLbl)
        numLbl.backgroundColor = .clear
        numLbl.textColor = UIColor(red: 0.87, green: 0.4, blue: 0.6, alpha: 1.00)
        numLbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        numLbl.textAlignment = .center
        numLbl.layer.borderColor = UIColor(red: 0.87, green: 0.4, blue: 0.6, alpha: 1.00).cgColor
        numLbl.layer.borderWidth = 2.4
        numLbl.layer.cornerRadius = 12.5
        
        numLbl.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(padding)
            make.width.height.equalTo(25)
        }
        
        contentView.addSubview(label)
        label.numberOfLines = 0
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.top.equalTo(numLbl.snp.top)
            make.left.equalTo(numLbl.snp.right).offset(10)
            make.right.equalTo(-padding)
//            make.bottom.equalTo(-10)
        }

        
        contentView.addSubview(image)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.left.equalTo(padding)
            make.right.equalTo(-padding)
            make.height.equalTo(190)
            make.bottom.equalTo(-10)
        }
        
        
        
    }

}
