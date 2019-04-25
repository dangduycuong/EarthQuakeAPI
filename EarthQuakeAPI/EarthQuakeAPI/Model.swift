//
//  Model.swift
//  EarthQuakeAPI
//
//  Created by duycuong on 4/25/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import Foundation


struct EarthQuakeService : Codable {
    var type: String
    var metadata: Metadata
    var features: [Features]
    var bbox: [Double]
}

struct Metadata : Codable {
    var generated: Int
    var url: String
    var status: Int
}

struct Features : Codable {
    var properties: Properties
    
    struct Properties : Codable {
        var place: String
        var code: String
        var title: String
    }
}

