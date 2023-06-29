//
//  SearchView.swift
//  EarthQuakeAPI
//
//  Created by cuongdd on 28/06/2023.
//  Copyright © 2023 duycuong. All rights reserved.
//

import UIKit

class SearchView: UIView {
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            paragraphStyle.lineHeightMultiple = 1.0
            let attributes = [
                NSAttributedString.Key.font: UIFont(name: "PlayfairDisplay-Italic", size: 17) as Any,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
            let attributedPlaceholder = NSAttributedString(string: "Search using keywords", attributes: attributes)
            searchTextField.attributedPlaceholder = attributedPlaceholder
        }
    }
    
    var textChange: ((String) -> ())?
    var beginEditing: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchTextField.delegate = self
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
}

extension SearchView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textChange?(textField.text ?? "")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        beginEditing?()
    }
}
