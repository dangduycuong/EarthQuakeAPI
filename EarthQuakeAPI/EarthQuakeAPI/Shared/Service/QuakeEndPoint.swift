//
//  QuakeEndPoint.swift
//  EarthQuakeAPI
//
//  Created by cuongdd on 20/3/25.
//  Copyright © 2025 duycuong. All rights reserved.
//

import Foundation
enum QuakeEndPoint {
    case getListEarthQuake
    case getEarthQuakeDetail(id: String)
}

extension QuakeEndPoint: APIType {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "earthquake.usgs.gov"
    }
    
    var path: String {
        switch self {
        case .getListEarthQuake:
            return "/earthquakes/feed/v1.0/summary/4.5_week.geojson"
        case .getEarthQuakeDetail(let id):
            return "/earthquakes/feed/v1.0/detail/\(id).geojson"
        }
    }
    
    var port: Int? {
        return nil
    }
    
    var bodyDictionary: Dictionary<String, Any>? {
        return nil
    }
    
    var bodyData: (any Codable)? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
