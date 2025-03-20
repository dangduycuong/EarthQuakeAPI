//
//  BaseViewController.swift
//  EarthQuakeAPI
//
//  Created by Dang Duy Cuong on 3/12/21.
//  Copyright © 2021 duycuong. All rights reserved.
//

import UIKit
import Material

import UIKit

enum PlayfairDisplay: String {
    case black = "PlayfairDisplay-Black"
    case blackItalic = "PlayfairDisplay-BlackItalic"
    case bold = "PlayfairDisplay-Bold"
    case boldItalic = "PlayfairDisplay-BoldItalic"
    
    case extraBold = "PlayfairDisplay-ExtraBold"
    case extraBoldItalic = "PlayfairDisplay-ExtraBoldItalic"
    case italic = "PlayfairDisplay-Italic"
    case medium = "PlayfairDisplay-Medium"
    
    case mediumItalic = "PlayfairDisplay-MediumItalic"
    case regular = "PlayfairDisplay-Regular"
    case semiBold = "PlayfairDisplay-SemiBold"
    case semiBoldItalic = "PlayfairDisplay-SemiBoldItalic"
}

public extension UIFont {
    
    static var black: UIFont {
        return UIFont(name: PlayfairDisplay.black.rawValue, size: 20)!
    }
    
    static var blackItalic: UIFont {
        return UIFont(name: PlayfairDisplay.blackItalic.rawValue, size: 20)!
    }
    
    static var bold: UIFont {
        return UIFont(name: PlayfairDisplay.bold.rawValue, size: 20)!
    }
    
    static var boldItalic: UIFont {
        return UIFont(name: PlayfairDisplay.boldItalic.rawValue, size: 20)!
    }
    
    static var extraBold: UIFont {
        return UIFont(name: PlayfairDisplay.extraBold.rawValue, size: 20)!
    }
    
    static var extraBoldItalic: UIFont {
        return UIFont(name: PlayfairDisplay.extraBoldItalic.rawValue, size: 20)!
    }
    
    static var italic: UIFont {
        return UIFont(name: PlayfairDisplay.italic.rawValue, size: 20)!
    }
    
    static var medium: UIFont {
        return UIFont(name: PlayfairDisplay.medium.rawValue, size: 20)!
    }
    
    static var mediumItalic: UIFont {
        return UIFont(name: PlayfairDisplay.mediumItalic.rawValue, size: 20)!
    }
    
    static var regular: UIFont {
        return UIFont(name: PlayfairDisplay.regular.rawValue, size: 20)!
    }
    
    static var semiBold: UIFont {
        return UIFont(name: PlayfairDisplay.semiBold.rawValue, size: 20)!
    }
    
    static var semiBoldItalic: UIFont {
        return UIFont(name: PlayfairDisplay.semiBoldItalic.rawValue, size: 20)!
    }
}

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bold
        return label
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.font = UIFont.medium
        
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        
        return tableView
    }()
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
    }
    
    func addBackButton() {
        let image = UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor.black
        
        view.layout(backButton)
            .topSafe()
            .left(8)
            .width(40).height(48)
        
        backButton.layout(imageView)
            .center()
            .width(24)
            .height(32)
    }
    
    func addTitle(_ title: String?) {
        view.layout(titleLabel)
            .topSafe()
            .centerX()
            .height(48)
        titleLabel.text = title
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    var spinner = UIActivityIndicatorView()
//    let alertService = AlertService()
    lazy var isLoading: Bool = false
    private var enableHideKeyBoardWhenTouchInScreen: Bool = true
    var isEnableHideKeyBoardWhenTouchInScreen: Bool {
        get {
            return self.enableHideKeyBoardWhenTouchInScreen ? true : false
        }
        
        set {
            self.enableHideKeyBoardWhenTouchInScreen = newValue
            if self.enableHideKeyBoardWhenTouchInScreen {
                let touchOnScreen = UITapGestureRecognizer(target: self, action: #selector(self.touchOnScreen))
                touchOnScreen.delegate = self
                touchOnScreen.cancelsTouchesInView = false
                view.addGestureRecognizer(touchOnScreen)
            }
        }
    }
    
    @objc func touchOnScreen() {
        view.endEditing(true)
    }
    
    func setSpinner() {
        view.alpha = 0.95
        spinner.style = .large
        spinner.color = #colorLiteral(red: 0, green: 0, blue: 0.5019607843, alpha: 1)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func showLoading() {
        setSpinner()
        spinner.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.view.alpha = 1
            self.spinner.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
//    func showAlertWithConfirm(type: AlertType, message: String, cancel: @escaping () -> Void, ok: @escaping () -> Void) -> Void {
//        let vc = alertService.showAlertWithConfirm(type: type, message: message, cancel: cancel, ok: ok)
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .crossDissolve
//        present(vc, animated: false, completion: nil)
//    }
    
//    func showAlertViewController(type: AlertType, message: String, close: @escaping () -> Void) -> Void {
//        let vc = alertService.showAlertViewController(type: type, message: message, close: close)
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .crossDissolve
//        present(vc, animated: false, completion: nil)
//    }
    
    func setShadowView(view: UIView) {
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
    }
    
    func setShadowButton(button: UIButton, cornerRadius: CGFloat) {
        button.layer.cornerRadius = cornerRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
    }
    
    func setPlaceholder(textView: UITextView, label: UILabel, text: String) {
        label.text = text
        label.font = UIFont.italicSystemFont(ofSize: (textView.font?.pointSize)!)
        label.sizeToFit()
        textView.addSubview(label)
        label.frame.origin = CGPoint(x: 5, y: (textView.font?.pointSize)! / 2)
        label.textColor = UIColor.lightGray
        label.isHidden = !textView.text.isEmpty
    }
    //login lai
//    func reLogin(resultcode: String, action: @escaping() -> ()) {
//        guard resultcode == "MS-0004" else {
//            return
//        }
//        self.showAlert(type: .notice, message: "Phiên đăng nhập của bạn đã hết hạn.\nVui lòng đăng nhập", close: {
//            let vc = Storyboard.Main.reLoginVC()
//            vc.modalPresentationStyle = .overFullScreen
//            vc.modalTransitionStyle = .crossDissolve
//            vc.actionReLogin = action
//            self.present(vc, animated: true, completion: nil)
//        })
//    }
    func backVC(controller: UIViewController){
        DispatchQueue.main.async {
            let vc = controller
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
            keyWindow?.rootViewController = vc
            keyWindow?.endEditing(true) //co cung thay chay ma bo di cung chay
        }
    }
}

