//
//  EarthquakeDetailViewController.swift
//  EarthQuakeAPI
//
//  Created by cuongdd on 27/06/2023.
//  Copyright © 2023 duycuong. All rights reserved.
//

import UIKit
import SwiftyJSON

class EarthquakeDetailViewController: UIViewController {
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.frame = view.bounds
        return scrollView
    }()
    
    fileprivate lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var animationVC: UIViewController = {
        let vc = AnimationLoadingViewController()
        return vc
    }()
    
    var detail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadData()
    }
    
    private func loadData() {
        showLoading()
        guard let detail = detail else { return }
        guard let url = URL(string: detail) else { return }
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        let sesstion = URLSession.shared
        let dataTask = sesstion.dataTask(with: request) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    self.setupUI(text: self.printFormatedJSON(data: data))
                }
            }
        }
        dataTask.resume()
    }
    
    func printFormatedJSON(data: Data) -> String {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            pringJSONData(jsonData)
            return String(decoding: jsonData, as: UTF8.self)
        } else {
            assertionFailure("Malformed JSON")
        }
        return "clgkbn"
    }
    
    private func pringJSONData(_ data: Data) {
        print(String(decoding: data, as: UTF8.self))
    }
    
    private func setupUI(text: String) {
        animationVC.dismiss(animated: true)
        view.addSubview(scrollView)
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        let heightConstraint = NSLayoutConstraint(item: contentView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        contentView.addConstraints([heightConstraint])
        
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.alignment = .left
        
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "PlayfairDisplay-Italic", size: 17) as Any,
            .paragraphStyle: paragraphStyle,
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        label.attributedText = attributedString
        label.numberOfLines = 0
        
        let button = UIButton(frame: CGRect(x: view.frame.maxX - 56, y: view.frame .maxY - 77, width: 40, height: 40))
        view.addSubview(button)
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        button.addTarget(self, action: #selector(onClickedDate), for: .touchUpInside)
    }
    
    private func showLoading() {
        animationVC.modalPresentationStyle = .overFullScreen
        animationVC.modalTransitionStyle = .crossDissolve
        present(animationVC, animated: true)
    }
    
    @objc func onClickedDate(_ sender: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc = storyboard?.instantiateViewController(withIdentifier: "DateHandlerViewController") as! DateHandlerViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
