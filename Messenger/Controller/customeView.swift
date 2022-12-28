//
//  customeView.swift
//  profile2
//
//  Created by admin on 11/8/22.
//

import Foundation
import UIKit


class ciercleView: UIView{
    func angleToRadian(angle: CGFloat) -> CGFloat{
        return angle * .pi / 180.0
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let cLayer = CAShapeLayer()
        cLayer.frame = bounds
        
        let radius = min(bounds.width, bounds.height) / 2.0
        let centerPoint = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        
        let path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: angleToRadian(angle: 0), endAngle: angleToRadian(angle: 360.0), clockwise: true)
        
        cLayer.path = path.cgPath
        layer.mask = cLayer
        
        
    }
}
