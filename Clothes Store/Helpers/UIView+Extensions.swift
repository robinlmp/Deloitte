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


/// This extension and the addition of the  manual background in the product detail view displayed modally from SwiftUI has fixed
/// some of the problems described in the SwiftUI catalogue view comments
extension UIView {
    func addBackground() {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        // you can change the content mode:
        background.contentMode = UIView.ContentMode.scaleAspectFill
        background.backgroundColor = UIColor.backgroundColour
        
        self.addSubview(background)
        self.sendSubviewToBack(background)
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

    }
    
    convenience init(imageTitle: ImageTitle) {
        self.init(named: imageTitle.rawValue)!
    }
}


// Native URL image loader extension
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }.resume()
        }
    }
}

// Extension for button press effect / animations. There's a bug with the animations as received
// which is described in the HUD file.
extension UIButton {
    func buttonPress(label: UILabel? = nil, pressedColour: UIColor) {
        
        guard let buttonBackground = self.backgroundColor else { return }
        guard let shadowColourCG = self.layer.shadowColor else { return }
        let shadowColour = UIColor(cgColor: shadowColourCG)
        let shadowOpacity = self.layer.shadowOpacity

        self.dropShadow(radius: 0, opacity: 0, color: .clear)
        self.backgroundColor = pressedColour
        
        if let label = label {
            label.isHidden = false
            AnimateMe.animateLabel(label)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dropShadow(radius: 8, opacity: shadowOpacity, color: shadowColour)
            self.backgroundColor = buttonBackground
            
            if let label = label {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    label.isHidden = true
                    
                }
            }
            
        }
    }
}
