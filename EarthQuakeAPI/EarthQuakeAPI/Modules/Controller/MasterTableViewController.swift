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
    private lazy var searchView: UIView = {
        let view: SearchView = SearchView.loadFromNib()
        return view
    }()
    
    let passwordField = PasswordTextField()
    
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
        if let searchView = searchView as? SearchView {
            searchView.textChange = { text in
                self.search(searchText: text)
            }
        }
        
        passwordField.placeholder = "Enter Password"
        passwordField.borderStyle = .roundedRect
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordField)
        
        NSLayoutConstraint.activate([
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordField.widthAnchor.constraint(equalToConstant: 250),
            passwordField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    private func setupUI() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.titleView = searchView
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray,
                .font: UIFont(name: "PlayfairDisplay-Italic", size: 17) as Any,
            ]
            let atrString = NSAttributedString(string: "Search using keywords", attributes: attributes)
            textfield.attributedPlaceholder = atrString
            //            textfield.font = UIFont(name: "PlayfairDisplay-Regular", size: 17)
            let defaultTextAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "PlayfairDisplay-Regular", size: 17) as Any,
            ]
            //            textfield.defaultTextAttributes = defaultTextAttributes
        }
        navigationController?.navigationBar.tintColor = .black
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        
        if #available(iOS 15, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.shadowColor = .clear
            navBarAppearance.shadowImage = UIImage()
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    // MARK: - Table view data source
    func setDataFromAPI() {
        let target = QuakeEndPoint.getListEarthQuake
        APIClient.shared.getData(with: target) { json in}
//        DataService.shared.getEarthQuakeAPI() { (json) in
//            //            self.totalErathQuake = earthQuakeService
//            self.totalErathQuakeDto = SummaryModel(byJSON: json)
//            if let features = self.totalErathQuakeDto?.features {
//                self.features = features
//                self.sourceList = features
//                self.tableView.reloadData()
//            }
//        }
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
