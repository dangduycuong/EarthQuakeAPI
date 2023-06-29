//
//  DateHandlerViewController.swift
//  EarthQuakeAPI
//
//  Created by cuongdd on 28/06/2023.
//  Copyright © 2023 duycuong. All rights reserved.
//

import UIKit

class DateHandlerViewController: UIViewController {
    @IBOutlet weak var startDateTextField: UITextField! {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            paragraphStyle.lineHeightMultiple = 1.0
            let attributes = [
                NSAttributedString.Key.font: UIFont(name: "PlayfairDisplay-Italic", size: 17) as Any,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
            let attributedPlaceholder = NSAttributedString(string: "Ngày bắt đầu", attributes: attributes)
            startDateTextField.attributedPlaceholder = attributedPlaceholder
        }
    }
    @IBOutlet weak var endTextField: UITextField! {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            paragraphStyle.lineHeightMultiple = 1.0
            let attributes = [
                NSAttributedString.Key.font: UIFont(name: "PlayfairDisplay-Italic", size: 17) as Any,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
            let attributedPlaceholder = NSAttributedString(string: "Ngày kết thúc", attributes: attributes)
            endTextField.attributedPlaceholder = attributedPlaceholder
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    
    private var isSelectStartDate: Bool = true
    private var startDate = Date()
    private var endDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        let datePickerView = UIDatePicker()
        datePickerView.preferredDatePickerStyle = .inline
        datePickerView.datePickerMode = .date
//        datePickerView.maximumDate = Date.now
        datePickerView.locale = Locale(identifier: "vi_VN")
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        startDateTextField.inputView = datePickerView
        endTextField.inputView = datePickerView
        dateLabel.text = " \n"
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, HH:mm:ss d MMMM, yyyy"
        dateFormatter.locale = Locale(identifier: "vi_VN")
        if isSelectStartDate {
            startDateTextField.text = dateFormatter.string(from: sender.date)
            startDate = sender.date
        } else {
            endDate = sender.date
            endTextField.text = dateFormatter.string(from: sender.date)
        }
    }
    
    func daysBetweenDates(startDate: Date, endDate: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.month, Calendar.Component.day], from: startDate, to: endDate)
        var display = ""
        if let month = components.month, month > 0 {
            display = "\(month) tháng "
        }
        if let day = components.day, day > 0 {
            display += "\(day) ngày"
        }
        if let days = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate).day, days > 0 {
            display += "\nTổng \(days) ngày"
        }
        dateLabel.text = display
    }
    
    @IBAction func onClickedCancul(_ sender: Any) {
        daysBetweenDates(startDate: startDate, endDate: endDate)
    }
    

}

extension DateHandlerViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == startDateTextField {
            isSelectStartDate = true
        } else {
            isSelectStartDate = false
        }
    }
}
