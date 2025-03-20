//
//  QuakeListViewController.swift
//  EarthQuakeAPI
//
//  Created by cuongdd on 20/3/25.
//  Copyright © 2025 duycuong. All rights reserved.
//

import UIKit

class QuakeListViewController: BaseViewController {
    private var features = [FeaturesModel]()
    private var suggestFeatures = [FeaturesModel]()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        view.layout(searchBar)
            .topSafe()
            .left(8)
            .right(8)
        
        view.layout(tableView)
            .below(searchBar)
            .left()
            .bottomSafe()
            .right()
        searchBar.delegate = self
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier())
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        showLoading()
        let target = QuakeEndPoint.getListEarthQuake
        APIClient.shared.getData(with: target) { json in
            self.hideLoading()
            self.features = [FeaturesModel](byJSON: json["features"])
            self.suggestFeatures = self.features
            self.tableView.reloadData()
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension QuakeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestFeatures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier(), for: indexPath) as! CustomTableViewCell
        cell.data = suggestFeatures[indexPath.row]
        cell.fillData(data: suggestFeatures[indexPath.row])
        
        return cell
    }
}

extension QuakeListViewController: UISearchBarDelegate {
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

extension QuakeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = QuakeDetailViewController()
        vc.quakeModel = suggestFeatures[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
