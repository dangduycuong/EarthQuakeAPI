//
//  ViewController.swift
//  EarthQuakeAPI
//
//  Created by duycuong on 4/25/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageLabel: UILabel! {
        didSet {
            pageLabel.text = suggestFeatures.count.toString()
        }
    }
    
    var features = [FeaturesModel]()
    var suggestFeatures = [FeaturesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLoading()
        
        DataService.shared.getEarthQuakeAPI(completedHandle: { [weak self] data in
            self?.hideLoading()
            let json = [FeaturesModel](byJSON: data["features"])
            self?.features = json
            self?.suggestFeatures = json
            self?.tableView.reloadData()
        })
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestFeatures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier(), for: indexPath) as! CustomTableViewCell
        cell.data = suggestFeatures[indexPath.row]
        cell.fillData()
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFeatures()
    }
    
    func filterFeatures() {
        if searchBar.text == "" {
            suggestFeatures = features
        } else {
            suggestFeatures = features.filter { (data: FeaturesModel) in
                if let text = searchBar.text, let place = data.properties?.place {
                    if place.lowercased().range(of: text.lowercased()) != nil {
                        return true
                    }
                }
                return false
            }
        }
        tableView.reloadData()
    }
}

