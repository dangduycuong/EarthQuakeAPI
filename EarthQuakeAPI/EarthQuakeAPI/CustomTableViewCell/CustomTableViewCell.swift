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
        magView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillData(data: FeaturesModel) {
        magLabel.text = data.properties?.mag?.toString()
        placeLabel.text = data.properties?.place
//
//
//        let width = magView.bounds.width
//        magView.layer.cornerRadius = width / 2
//
        if let time = data.properties?.time {
            let epochTime = TimeInterval(time) / 1000
            let date = Date(timeIntervalSince1970: epochTime)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd - MM - yyyy | HH : mm : ss z"
            timeLabel.text = dateFormatter.string(from: date)
        }
    }
    
    func fillData(mag: Double?, place: String?, time: Int?, keyWord: String?) {
        magLabel.text = mag?.toString()
        placeLabel.text = place
        if let time = time {
            convertTime(time: time)
        }
        
        guard let name = place, let keyWord = keyWord else {
            return
        }
        let range = findRange(source: name.folded.lowercased(), textToFind: keyWord.folded.lowercased())
        if range.location != NSNotFound {
            setColorTextLabel(string: name, range: range)
        } else {
            placeLabel.text = name
        }
    }
    
    private func convertTime(time: Int) {
        let epochTime = TimeInterval(time) / 1000
        let date = Date(timeIntervalSince1970: epochTime)   // "Apr 16, 2015, 2:40 AM"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd - MM - yyyy | HH : mm : ss z"
        timeLabel.text = dateFormatter.string(from: date)
    }
    
    func findRange(source: String, textToFind: String) -> NSRange {
        let string = NSMutableAttributedString(string: source.folded.lowercased())
        
        let range = string.mutableString.range(of: textToFind.folded.lowercased(), options: .caseInsensitive)
        return range
    }
    
    func setColorTextLabel(string: String, range: NSRange) {
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: string)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGreen, range: range)
        placeLabel.attributedText = myMutableString
    }

}

extension Double {
    func toString() -> String {
        return String(self)
    }
}

extension String {
    var folded: String {
        return self.folding(options: .diacriticInsensitive, locale: nil)
            .replacingOccurrences(of: "đ", with: "d")
            .replacingOccurrences(of: "Đ", with: "D")
    }
}
