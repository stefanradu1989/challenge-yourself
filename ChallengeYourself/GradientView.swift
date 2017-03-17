//
//  GradientView.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 27/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var startColor:   UIColor = ColorUtils.hexStringToUIColor(hex: "#ffad33") { didSet { updateColors() }}
//    @IBInspectable var midColor:     UIColor = .orange { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = ColorUtils.hexStringToUIColor(hex: "#cc7a00") { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
//    @IBInspectable var midLocation:   Double =   0.55 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber] //, midLocation as NSNumber
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor] //, midColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
