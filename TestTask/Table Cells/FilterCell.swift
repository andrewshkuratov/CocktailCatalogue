//
//  FilterCell.swift
//  TestTask
//
//  Created by Andrew on 14.09.2020.
//  Copyright © 2020 com.andrewShkuratov. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {
    var filterName: UILabel = {
        var fn = UILabel()
        fn.font = UIFont(name: "Helvetica", size: 16)
        fn.numberOfLines = 0
        fn.translatesAutoresizingMaskIntoConstraints = false
        return fn
    }()
    
    var isChoosen: Bool = true {
        didSet {
            if isChoosen {
                accessoryType = .checkmark
            } else {
                accessoryType = .none
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func setupView() {
        addSubview(filterName)
        addConstraintsWithFormat(format: "V:|-25-[v0(40)]-25-|", views: filterName)
        addConstraintsWithFormat(format: "H:|-30-[v0]-10-|", views: filterName)
    }
}
