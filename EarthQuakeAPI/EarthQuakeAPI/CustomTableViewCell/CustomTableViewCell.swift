//
//  CustomTableViewCell.swift
//  EarthQuakeAPI
//
//  Created by duycuong on 4/25/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class CustomTableViewCell: BaseTableViewCell {
    @IBOutlet weak var magLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var magView: UIView!
    
    var data = FeaturesModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillData() {
        magLabel.text = data.properties?.mag
        placeLabel.text = data.properties?.place
        
        
        let width = magView.bounds.width
        magView.layer.cornerRadius = width / 2
        
        if let time = data.properties?.time?.toInt() {
            let epochTime = TimeInterval(time) / 1000
            let date = Date(timeIntervalSince1970: epochTime)   // "Apr 16, 2015, 2:40 AM"

            print("Converted Time \(date)")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd - MM - yyyy | HH : mm : ss z"
            timeLabel.text = dateFormatter.string(from: date)
        }
    }

}
