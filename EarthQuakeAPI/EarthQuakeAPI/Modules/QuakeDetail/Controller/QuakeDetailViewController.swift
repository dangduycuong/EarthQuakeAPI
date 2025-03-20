//
//  QuakeDetailViewController.swift
//  EarthQuakeAPI
//
//  Created by cuongdd on 20/3/25.
//  Copyright © 2025 duycuong. All rights reserved.
//

import UIKit

class QuakeDetailViewController: BaseViewController {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        
        return stackView
    }()
    var quakeModel = FeaturesModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addBackButton()
        addTitle(quakeModel.properties?.title)
        view.layout(stackView)
            .below(titleLabel, 8)
            .left(16)
            .right(16)
        guard let id = quakeModel.id else { return }
        showLoading()
        let target = QuakeEndPoint.getEarthQuakeDetail(id: id)
        APIClient.shared.getData(with: target) { json in
            self.hideLoading()
            let model = FeaturesModel(byJSON: json)
            DispatchQueue.main.async {
                if let time = model?.properties?.time {
                    self.fillDate(time: time)
                }
                if let coordinates = model?.geometry?.coordinates {
                    self.fillCoordinates(coordinates: coordinates)
                }
//                if let depth = model?.properties?.products?.origin?.first?.depth {
//                    self.fillDepth(depth: depth)
//                }
            }
        
        }
    }
    
    func fillDate(time: Int) {
        let epochTime = TimeInterval(time) / 1000
        let date = Date(timeIntervalSince1970: epochTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "'Time:' dd - MM - yyyy HH : mm : ss z"
        
        let label = UILabel()
        label.font = UIFont.medium
        label.text = dateFormatter.string(from: date)
        stackView.addArrangedSubview(label)
    }
    
    func fillCoordinates(coordinates: [Double]) {
        if coordinates.count >= 2 {
            let longitude = coordinates[0]
            let latitude = coordinates[1]

            let latitudeDirection = latitude >= 0 ? "N" : "S"
            let longitudeDirection = longitude >= 0 ? "E" : "W"

            let formattedLatitude = String(format: "%.3f°%@", abs(latitude), latitudeDirection)
            let formattedLongitude = String(format: "%.3f°%@", abs(longitude), longitudeDirection)

            print("Location: \(formattedLatitude) \(formattedLongitude)")
            let label = UILabel()
            label.font = UIFont.medium
            label.text = "Location: \(formattedLatitude) \(formattedLongitude)"
            stackView.addArrangedSubview(label)
            
            if let stringValue = coordinates.last?.toString() {
                fillDepth(depth: stringValue)
            }
        } else {
            print("Error: Not enough coordinates provided.")
        }
    }
    
    func fillDepth(depth: String) {
        let label = UILabel()
        label.font = UIFont.medium
        label.text = "Depth: \(depth) km"
        stackView.addArrangedSubview(label)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
