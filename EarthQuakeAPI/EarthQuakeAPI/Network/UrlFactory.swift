//
//  UrlFactory.swift
//  EarthQuakeAPI
//
//  Created by duycuong on 4/25/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

//import Foundation
//
//enum URLFactory {
//    case earthQuake
//
//    //https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_week.geojson
//
//    var URL : URL {
//        func generaUrlComponent(path: String) -> URL {
//            var urlComponent = URLComponents()
//            urlComponent.scheme = "https"
//            urlComponent.host = "earthquake.usgs.gov"
//            urlComponent.path = path
//            return urlComponent.url!
//        }
//
//        // call path
//        switch self {
//            case .earthQuakeAPI:
//                return generaUrlComponent(path: "earthquakes/feed/v1.0/summary/4.5_week.geojson")
//        }
//    }
//}
