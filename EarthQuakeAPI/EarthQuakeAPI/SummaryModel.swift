//
//  SummaryModel.swift
//  EarthQuakeAPI
//
//  Created by Dang Duy Cuong on 3/12/21.
//  Copyright © 2021 duycuong. All rights reserved.
//

import Foundation
import SwiftyJSON

class SummaryModel: BaseDataModel {
    var type: String?
    var metadata: MetadataModel?
    var features: [FeaturesModel]?
    
    override func mapping(json: JSON) {
        type = json["type"].stringValue
        metadata = MetadataModel(byJSON: json["metadata"])
        features = [FeaturesModel](byJSON: json["features"])
    }
}

class MetadataModel: BaseDataModel {
    var generated: String?
    var url: String?
    var title: String?
    var status: String?
    
    var api: String?
    var count: String?
    
    override func mapping(json: JSON) {
        generated = json["generated"].stringValue
        url = json["url"].stringValue
        title = json["title"].stringValue
        status = json["status"].stringValue
        
        api = json["api"].stringValue
        count = json["count"].stringValue
    }
}

class FeaturesModel: BaseDataModel {
    var type: String?
    var properties: PropertiesModel?
    var id: String?
    var geometry: GeometryModel?
    
    override func mapping(json: JSON) {
        type = json["type"].stringValue
        properties = PropertiesModel(byJSON: json["properties"])
        id = json["id"].string
        geometry = GeometryModel(byJSON: json["geometry"])
    }
}

class PropertiesModel: BaseDataModel {
    var mag: Double?
    var place: String?
    var time: Int?
    var detail: String?
    var title: String?
    var products: ProductsModel?
    
    override func mapping(json: JSON) {
        mag = json["mag"].double
        place = json["place"].stringValue
        time = json["time"].intValue
        detail = json["detail"].stringValue
        title = json["title"].string
        products = ProductsModel(byJSON: json["products"])
    }
}

class GeometryModel: BaseDataModel {
    var coordinates: [Double]?
    override func mapping(json: JSON) {
        self.coordinates = json["coordinates"].arrayValue.map { $0.doubleValue }
    }
}

class ProductsModel: BaseDataModel {
    var origin: [OriginModel]?
    override func mapping(json: JSON) {
        origin = [OriginModel](byJSON: json["origin"])
    }
}

class OriginModel: BaseDataModel {
    var depth: String?
    override func mapping(json: JSON) {
        depth = json["properties"]["depth"].string
    }
    
}
