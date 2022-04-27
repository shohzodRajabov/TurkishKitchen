//
//  MenuTableViewCell.swift
//  TurkishCuisineOne
//
//  Created by Shohzod Rajabov on 01/12/21.
//

import UIKit

class MenuCell: UITableViewCell {
    
    let icon = UIImageView()
    let menuLbl = UILabel()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .black
        
        addSubview(icon)
        icon.tintColor = UIColor(red: 0.77, green: 0.4, blue: 0.6, alpha: 1.00)
        icon.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(25)
        }
        
        addSubview(menuLbl)
        menuLbl.backgroundColor = .clear
        menuLbl.textColor = .white
        menuLbl.textAlignment = .center
        menuLbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        menuLbl.snp.makeConstraints({ make in
            make.left.equalTo(icon.snp.right).offset(10)
            make.centerY.equalToSuperview()
        })
        
    }

}
