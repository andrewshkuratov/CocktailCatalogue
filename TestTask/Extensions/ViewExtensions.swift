//
//  ViewExtensions.swift
//  TestTask
//
//  Created by Andrew on 14.09.2020.
//  Copyright © 2020 com.andrewShkuratov. All rights reserved.
//

import UIKit

extension UIView {
    //MARK: Function that add constraints with text visual format
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
