//
//  UIView+Extensions.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

extension UIView {
    
    func dropShadow(scale: Bool = true, radius: CGFloat, opacity: Float, color: UIColor) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = radius

        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

@IBDesignable class DesignableImageView: UIImageView {}
@IBDesignable class DesignableButton: UIButton{}
@IBDesignable class DesignableTextField: UITextField {}
@IBDesignable class DesignableLabel: UILabel {}


extension UIView {

    @IBInspectable

    var borderwidth: CGFloat {
        get {
            return layer.borderWidth
        }

        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable

    var borderColor: UIColor? {
        get {
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable

    var cornerRadiusMe: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue != 0
        }
    }
}

extension UIAlertController{

    class func show(_ title: String, message: String, from controller: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        controller.present(alert, animated: true)
    }
}


extension UIImage {
    enum ImageTitle: String {
        case placeHolder = "photo.placeholder"
        case photo = "ohoto"
    }
    
    convenience init(imageTitle: ImageTitle) {
        self.init(named: imageTitle.rawValue)!
    }
}

@available(iOS 13.0, *)
extension UIImage {
    enum SFSymbol: String {
//        add SFSymbol cases here
        case cart = "cart"
    }
    
    convenience init(symbol: SFSymbol) {
        self.init(systemName: symbol.rawValue)!
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
