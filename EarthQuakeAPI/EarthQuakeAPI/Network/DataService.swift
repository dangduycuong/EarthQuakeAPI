//
//  DataService.swift
//  EarthQuakeAPI
//
//  Created by duycuong on 4/25/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataService  {
    static var shared: DataService = DataService()
    
    func getEarthQuakeAPI(completedHandle: @escaping(JSON) -> Void) {
        guard let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_week.geojson") else { return }
        
        let urlRequest = URLRequest(url: url)
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data {
                if let json = try? JSON(data: data) {
                    print("response: ", json)
                    DispatchQueue.main.async {
                        completedHandle(json)
                    }
                }
            }
        })
        
        downloadTask.resume()
    }
}
