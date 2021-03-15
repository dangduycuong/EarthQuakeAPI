////
////  MasterTableViewController.swift
////  EarthQuakeAPI
////
////  Created by duycuong on 4/25/19.
////  Copyright © 2019 duycuong. All rights reserved.
////
//
//import UIKit
//
//class MasterTableViewController: UITableViewController {
//    
//    var totalErathQuake: EarthQuakeService?
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.rowHeight = 600
//        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier())
//        setDataFromAPI()
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }
//    
//    func setDataFromAPI() {
////        DataService.api.getEarthQuakeAPI() { (earthQuakeService) in
////            self.totalErathQuake = earthQuakeService
//            self.tableView.reloadData()
//        }
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier(), for: indexPath) as! CustomTableViewCell
//        // Configure the cell...
////        cell.codeLabel.text = totalErathQuake?.features[indexPath.row].properties.code
////        cell.generatedLabel.text = String(totalErathQuake?.metadata.generated ?? 1234)
////        cell.placeLabel.text = totalErathQuake?.features[indexPath.row].properties.place
////        cell.statusLabel.text = String(totalErathQuake?.metadata.status ?? 123123)
////        cell.titleLabel.text = totalErathQuake?.features[indexPath.row].properties.title
////        cell.typeLabel.text = totalErathQuake?.type
////        cell.urlLabel.text = totalErathQuake?.metadata.url
////        cell.bbox.text = String(totalErathQuake?.bbox[indexPath.row] ?? 6789)
//        print(totalErathQuake?.features.count)
//        return cell
//    }
//    
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
