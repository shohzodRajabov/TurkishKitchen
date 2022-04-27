//
//  IngredientsCell.swift
//  TurkishCuisineOne
//
//  Created by Shohzod Rajabov on 03/12/21.
//

import UIKit

class IngredientsCell: UITableViewCell {

    let lineView = UIView()
    let label = UILabel()
    let padding = 5

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .black
        
        contentView.addSubview(lineView)
        lineView.backgroundColor = .systemYellow
        lineView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(padding)
            make.width.equalTo(25)
            make.height.equalTo(3)
        }
        
        contentView.addSubview(label)
        label.numberOfLines = 0
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(lineView.snp.right).offset(10)
            make.right.equalTo(-padding)
            make.bottom.equalTo(-5)
        }
        
        
    }

}
