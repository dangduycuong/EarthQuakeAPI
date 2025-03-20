//
//  APIType.swift
//  EarthQuakeAPI
//
//  Created by cuongdd on 20/3/25.
//  Copyright © 2025 duycuong. All rights reserved.
//

import Foundation

protocol APIType {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var port: Int? { get }
    var bodyDictionary: Dictionary<String, Any>? { get }
    var bodyData: Codable? { get }
    var queryItems: [URLQueryItem]? { get }
    var method: String { get }
    var headers: [String : String]? { get }
}
