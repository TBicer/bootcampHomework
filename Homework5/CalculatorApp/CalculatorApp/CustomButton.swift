//
//  CustomButton.swift
//  CalculatorApp
//
//  Created by Tunay Biçer on 28.09.2024.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable var shadowOffsetWidth: CGFloat = 2 {
        didSet {
            self.layer.shadowOffset.width = shadowOffsetWidth
        }
    }

    @IBInspectable var shadowOffsetHeight: CGFloat = 2 {
        didSet {
            self.layer.shadowOffset.height = shadowOffsetHeight
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 4 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
    }
    
}
