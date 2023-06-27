//
//  MasterTableViewController.swift
//  EarthQuakeAPI
//
//  Created by duycuong on 4/25/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit
import SwiftyJSON

class MasterTableViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var totalErathQuake: EarthQuakeService?
    var totalErathQuakeDto: SummaryModel?
    var features = [FeaturesModel]()
    var sourceList = [FeaturesModel]()
    private var keyWord: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        searchBar.delegate = self
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier())
        setDataFromAPI()
    }
    
    private func setupUI() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.titleView = searchBar
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray,
                .font: UIFont(name: "PlayfairDisplay-Italic", size: 17) as Any,
            ]
            let atrString = NSAttributedString(string: "Search using keywords", attributes: attributes)
            textfield.attributedPlaceholder = atrString
            textfield.font = UIFont(name: "PlayfairDisplay-Regular", size: 17)
        }
        navigationController?.navigationBar.tintColor = .black
    }
    
    // MARK: - Table view data source
    func setDataFromAPI() {
        DataService.shared.getEarthQuakeAPI() { (json) in
            //            self.totalErathQuake = earthQuakeService
            self.totalErathQuakeDto = SummaryModel(byJSON: json)
            if let features = self.totalErathQuakeDto?.features {
                self.features = features
                self.sourceList = features
                self.tableView.reloadData()
            }
        }
    }
    
}


extension MasterTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier(), for: indexPath) as! CustomTableViewCell
        cell.fillData(mag: features[indexPath.row].properties?.mag, place: features[indexPath.row].properties?.place, time: features[indexPath.row].properties?.time, keyWord: keyWord)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EarthquakeDetailViewController") as! EarthquakeDetailViewController
        vc.detail = features[indexPath.row].properties?.detail
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MasterTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText: searchText)
    }
    
    private func search(searchText: String) {
        keyWord = searchText
        features = sourceList.filter { (feature: FeaturesModel) in
            if searchText == "" {
                return true
            }
            if let place = feature.properties?.place?.lowercased().unaccent() {
                if place.range(of: searchText) != nil {
                    return true
                }
            }
            return false
        }
        tableView.reloadData()
    }
}

extension String {
    func unaccent() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}
