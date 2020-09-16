//
//  ViewController.swift
//  TestTask
//
//  Created by Andrew on 14.09.2020.
//  Copyright © 2020 com.andrewShkuratov. All rights reserved.
//

import UIKit
import SwiftyJSON

public var reusableId = "cellId"

protocol CocktailControllerDelegate: class {
    func updateFilter(_ filter: [Filter])
}

class CocktailController: UIViewController, CocktailControllerDelegate {
    var usingFilters: [Filter] = []
    var allFilters: [Filter] = []
    
    var cocktailTableSection: [CocktailTableSection] = []
    var currentPage = 0
    @IBOutlet weak var tableView: UITableView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLeftBarTitle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(CocktailCell.self, forCellReuseIdentifier: reusableId)
        tableView?.separatorStyle = .none
        
        if Reachability.isConnectedToNetwork() {
            loadCategories()
        } else {
            let alert = UIAlertController(title: "Alert", message: "There are no internet connection", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    //MARK: Configuring Left Nav Bar
    func setLeftBarTitle() {
        let leftBarTitle: UIBarButtonItem = {
            let t = UIBarButtonItem()
            t.title = "Drinks"
            t.style = .plain
            t.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18)!], for: UIControl.State.normal)
            t.tintColor = .black
            return t
        }()
        
        navigationItem.leftBarButtonItems = [leftBarTitle]
    }
    
    //MARK: Sending filters to FiltersController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toFiltersList" else { return }
        guard let destination = segue.destination as? FilterController else { return }
        destination.filters = self.allFilters
        destination.delegate = self
    }
    
    //MARK: Updating the list of filters
    func updateFilter(_ filter: [Filter]) {
        self.allFilters = filter
        
        var tempFilters: [Filter] = []
        
        for item in filter {
            if item.isChoosen {
                tempFilters.append(item)
            }
        }
        
        self.usingFilters = tempFilters
        cocktailTableSection = []
        guard !self.usingFilters.isEmpty else {
            print(#line)
            return
        }
        currentPage = 0
        loadCocktails(self.usingFilters[0].name)
    }
}

//MARK: Networking Area
extension CocktailController {
    //MARK: Getting list of all cocktails filters
    func loadCategories() {
        ServiceLayer.request(router: .filters) { (json) in
            guard json.exists() else {
                print(#line)
                return
            }
            
            for item in 0..<json[0]["drinks"].count {
                guard json[0]["drinks"][item]["strCategory"].string != nil else { return }
                let filter = Filter(name: json[0]["drinks"][item]["strCategory"].string!, isChoosen: true)
                self.usingFilters.append(filter)
            }
            
            self.allFilters = self.usingFilters
            let f = self.usingFilters[self.currentPage].name
            self.loadCocktails(f)
        }
    }
    
    //MARK: Getting list of Cocktails
    func loadCocktails(_ filter: String) {
        if usingFilters.count != 0 {
            ServiceLayer.request(router: .cocktails, "c=\(filter.replacingOccurrences(of: " ", with: "_"))") { (json) in
                var ckt: [Cocktail] = []
                print(filter)
                
                for item in 0..<json[0]["drinks"].count {
                    guard json[0]["drinks"][item]["strDrink"].string != nil else { return }
                    guard json[0]["drinks"][item]["strDrinkThumb"].string != nil else { return }
                    
                    let cocktail = Cocktail(name: json[0]["drinks"][item]["strDrink"].string!, image: json[0]["drinks"][item]["strDrinkThumb"].string!)
                    ckt.append(cocktail)
                }
                
                let ckts = CocktailTableSection(name: filter, cocktails: ckt)
                self.cocktailTableSection.append(ckts)
                
                self.tableView?.reloadData()
            }
        }
    }
}

extension CocktailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let category = UILabel()
        category.textColor = .gray
        category.sizeToFit()
        category.backgroundColor = .white
        
        guard cocktailTableSection.count != 0 else { return category }
        
        category.text = "     " + cocktailTableSection[section].name
        return category
    }
}

extension CocktailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard cocktailTableSection.count != 0 else { return 0 }
        return cocktailTableSection[section].cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableId, for: indexPath) as! CocktailCell
        cell.cocktailName.text = cocktailTableSection[indexPath.section].cocktails[indexPath.row].name
        cell.cocktailImage.loadImageUsingUrlString(imageURL: cocktailTableSection[indexPath.section].cocktails[indexPath.row].image)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cocktailTableSection.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CocktailController {
    //MARK: Pagination
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(usingFilters)
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height )){
            if currentPage < usingFilters.count - 1 {
                currentPage += 1
                loadCocktails(usingFilters[currentPage].name)
            }
        }
    }
}
