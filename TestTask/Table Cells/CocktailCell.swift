//
//  CocktailCell.swift
//  TestTask
//
//  Created by Andrew on 14.09.2020.
//  Copyright © 2020 com.andrewShkuratov. All rights reserved.
//

import UIKit

class CocktailCell: UITableViewCell {
    var cocktailImage: CustomImageView = {
        let ci = CustomImageView()
        ci.translatesAutoresizingMaskIntoConstraints = false
        return ci
    }()
    
    var cocktailName: UILabel = {
        let cn = UILabel()
        cn.font = UIFont(name: "Helvetica", size: 16)
        cn.numberOfLines = 0
        cn.textColor = .gray
        cn.translatesAutoresizingMaskIntoConstraints = false
        return cn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func setupView() {
        self.addSubview(cocktailImage)
        self.addSubview(cocktailName)
        addConstraintsWithFormat(format: "V:|-20-[v0(100)]-20-|", views: cocktailImage)
        addConstraintsWithFormat(format: "V:|-20-[v0]-20-|", views: cocktailName)
        addConstraintsWithFormat(format: "H:|-20-[v0(100)]-[v1]-20-|", views: cocktailImage, cocktailName)
    }
}
