//
//  FiltersController.swift
//  TestTask
//
//  Created by Andrew on 14.09.2020.
//  Copyright © 2020 com.andrewShkuratov. All rights reserved.
//

import UIKit
import SwiftyJSON

class FilterController: UIViewController {
    var filters: [Filter] = []
    weak var delegate: CocktailControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var applyButton: UIButton?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackButtonImage()
        self.tableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(FilterCell.self, forCellReuseIdentifier: reusableId)
        tableView?.separatorStyle = .none
        
        applyButton?.addTarget(self, action: #selector(applyButtonClicked(sender:)), for: .touchUpInside)
    }
    
    //MARK: Button that returns to pravious controller
    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated:true)
    }
    
    //MARK: Button that returns to previous controller and updates data
    @objc func applyButtonClicked(sender: UIBarButtonItem) {
        delegate?.updateFilter(filters)
        self.navigationController?.popViewController(animated:true)
    }
}

extension FilterController {
    //MARK: Setting Up Left NavBar Back Button
    func setBackButtonImage() {
        navigationItem.hidesBackButton = true
        let leftBarButton: UIBarButtonItem = {
            let b = UIBarButtonItem()
            b.image = #imageLiteral(resourceName: "backButton")
            b.style = .plain
            b.target = self
            b.action = #selector(back(sender:))
            b.tintColor = .black
            return b
        }()
        
        let leftBarTitle: UIBarButtonItem = {
            let t = UIBarButtonItem()
            t.title = "Filters"
            t.style = .plain
            t.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18)!], for: UIControl.State.normal)
            t.tintColor = .black
            return t
        }()
        
        navigationItem.leftBarButtonItems = [leftBarButton, leftBarTitle]
    }
}

extension FilterController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterCell
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            filters[indexPath.row].isChoosen = !filters[indexPath.row].isChoosen
        } else if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            filters[indexPath.row].isChoosen = !filters[indexPath.row].isChoosen
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FilterController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableId, for: indexPath) as! FilterCell
        
        cell.filterName.text = filters[indexPath.row].name
        
        if filters[indexPath.row].isChoosen {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}
