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
    
    override func mapping(json: JSON) {
        type = json["type"].stringValue
        properties = PropertiesModel(byJSON: json["properties"])
    }
}

class PropertiesModel: BaseDataModel {
    var mag: String?
    var place: String?
    var time: String?
    
    override func mapping(json: JSON) {
        mag = json["mag"].stringValue
        place = json["place"].stringValue
        time = json["time"].stringValue
    }
}
