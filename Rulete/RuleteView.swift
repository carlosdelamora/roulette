//
//  RleteImage.swift
//  Rulete
//
//  Created by Carlos De la mora on 10/25/17.
//  Copyright © 2017 carlosdelamora. All rights reserved.
//

import UIKit

@IBDesignable
class RuleteView: UIView {
    
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(ovalIn: rect)
        let color = UIColor.brown
        color.setFill()
        path.fill()
        
        for i in (0...38){
            addField(number: i)
        }
        
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let arcWidth = bounds.width/8 //radius/2
        let radius = bounds.width/2 - arcWidth
        let insidePath = UIBezierPath(arcCenter: center, radius: radius - 1, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        insidePath.lineWidth = 2
        UIColor.black.setStroke()
        insidePath.stroke()
       
    }
    
    private struct Constants {
        static let numberOfGlasses = 8
        static let lineWidth: CGFloat = 5.0
        static let arcWidth: CGFloat = 76
        
        static var halfOfLineWidth: CGFloat {
            return lineWidth / 2
        }
    }
 
    func addField(number:Int){
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius = bounds.width/2
        let cgfloatNumber = CGFloat(number)
        let startAngle: CGFloat = cgfloatNumber * 2 * .pi / 39
        let endAngle: CGFloat = (cgfloatNumber + 1) * 2 * .pi / 39
        
        let arcWidth = radius/4
        let arcPath = UIBezierPath(arcCenter: center, radius: radius - arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        arcPath.lineWidth = arcWidth
        var color: UIColor = .red
        switch number % 2{
        case 0:
            color = .red
        case 1:
            color = .black
        default:
            break
        }
        if number == 0{
            color = .green
        }
        if number == 19 {
            color = .green
        }
        
        color.setStroke()
        arcPath.stroke()
    }

}
