//
//  MealCell.swift
//  TurkishCuisineOne
//
//  Created by Shohzod Rajabov on 03/12/21.
//

import UIKit

class MealCell: UITableViewCell {
    
    let image = UIImageView()
    let label = UILabel()
    let padding = 5

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .black
        
        contentView.addSubview(image)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(padding)
            make.right.equalTo(-padding)
            make.height.equalTo(190)
        }
        
        contentView.addSubview(label)
        label.numberOfLines = 0
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(2)
            make.left.equalTo(padding)
            make.right.equalTo(-padding)
            make.bottom.equalTo(-10)
        }
        
        
    }

}
