//
//  EarthquakeDetailViewController.swift
//  EarthQuakeAPI
//
//  Created by cuongdd on 27/06/2023.
//  Copyright © 2023 duycuong. All rights reserved.
//

import UIKit

class EarthquakeDetailViewController: UIViewController {
    
    var detail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    private func loadData() {
        guard let detail = detail else { return }
        guard let url = URL(string: detail) else { return }
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        let sesstion = URLSession.shared
        let dataTask = sesstion.dataTask(with: request) { (data, response, error) in
            data?.printFormatedJSON()
        }
        dataTask.resume()
    }
    
}

import Foundation

extension Data {
    
    func printResponseJson() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("json data malformed")
        }
    }
    
    func printFormatedJSON() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            pringJSONData(jsonData)
        } else {
            assertionFailure("Malformed JSON")
        }
    }
    
    private func pringJSONData(_ data: Data) {
        print(String(decoding: data, as: UTF8.self))
    }
}
