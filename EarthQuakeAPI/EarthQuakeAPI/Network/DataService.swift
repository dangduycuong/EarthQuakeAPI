//
//  DataService.swift
//  EarthQuakeAPI
//
//  Created by duycuong on 4/25/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import Foundation

class DataService  {
    static var api: DataService = DataService()
    
    func getEarthQuakeAPI(completedHandle: @escaping(EarthQuakeService) -> Void) {
        guard let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_week.geojson") else { return }
        
        let urlRequest = URLRequest(url: url)
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            do {
                let earthQuakeData = try JSONDecoder().decode(EarthQuakeService.self, from: data!)
                DispatchQueue.main.async {
                    completedHandle(earthQuakeData)
                }
            } catch {}
        })
        
        downloadTask.resume()
    }
}
